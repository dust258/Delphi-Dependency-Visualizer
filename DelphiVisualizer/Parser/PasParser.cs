using System.IO;
using System.Text.RegularExpressions;

namespace DelphiVisualizer.Parser;

public static class PasParser
{
    private static readonly Regex UnitNameRegex =
        new(@"^\s*(\w+)", RegexOptions.Compiled);

    public static (List<string> InterfaceUses, List<string> ImplementationUses) Parse(string filePath)
    {
        if (!File.Exists(filePath))
            return (new(), new());

        var text = File.ReadAllText(filePath);
        var stripped = StripComments(text);

        var interfaceUses = ExtractUsesBetween(stripped, "interface", "implementation");
        var implUses = ExtractUsesAfter(stripped, "implementation");

        return (interfaceUses, implUses);
    }

    private static List<string> ExtractUsesBetween(string text, string afterKeyword, string beforeKeyword)
    {
        int sectionStart = FindTopLevelKeyword(text, afterKeyword);
        if (sectionStart < 0) return new();

        int sectionEnd = FindTopLevelKeyword(text, beforeKeyword, sectionStart + afterKeyword.Length);
        if (sectionEnd < 0) sectionEnd = text.Length;

        var section = text[sectionStart..sectionEnd];
        return ExtractUsesFromSection(section);
    }

    private static List<string> ExtractUsesAfter(string text, string afterKeyword)
    {
        int pos = FindTopLevelKeyword(text, afterKeyword);
        if (pos < 0) return new();

        var section = text[(pos + afterKeyword.Length)..];
        return ExtractUsesFromSection(section);
    }

    private static List<string> ExtractUsesFromSection(string section)
    {
        // Find "uses" keyword
        int usesPos = FindTopLevelKeyword(section, "uses");
        if (usesPos < 0) return new();

        int afterUses = usesPos + 4;

        // Find terminating semicolon (not inside nested constructs)
        int depth = 0;
        int end = -1;
        for (int i = afterUses; i < section.Length; i++)
        {
            if (section[i] == '(') depth++;
            else if (section[i] == ')') depth--;
            else if (section[i] == ';' && depth == 0) { end = i; break; }
        }

        if (end < 0) end = section.Length;
        var usesBody = section[afterUses..end];

        return ParseUnitList(usesBody);
    }

    private static List<string> ParseUnitList(string body)
    {
        var result = new List<string>();
        var entries = body.Split(',');

        foreach (var entry in entries)
        {
            var trimmed = entry.Trim();
            if (string.IsNullOrEmpty(trimmed)) continue;

            // Handle "UnitName in 'path'" syntax — take only the unit name
            var nameMatch = UnitNameRegex.Match(trimmed);
            if (!nameMatch.Success) continue;

            var name = nameMatch.Groups[1].Value;
            if (!string.IsNullOrEmpty(name) && !IsKeyword(name))
                result.Add(name);
        }

        return result;
    }

    // Finds a keyword at the top level (not inside strings or nested blocks).
    // The comment stripper already removed all comments, so we only need to
    // worry about string literals and parenthesis depth.
    private static int FindTopLevelKeyword(string text, string keyword, int startFrom = 0)
    {
        int i = startFrom;
        while (i <= text.Length - keyword.Length)
        {
            // Quick check: is character at i the first char of keyword?
            if (char.ToUpperInvariant(text[i]) == char.ToUpperInvariant(keyword[0]))
            {
                if (string.Compare(text, i, keyword, 0, keyword.Length, StringComparison.OrdinalIgnoreCase) == 0)
                {
                    // Verify word boundary
                    bool beforeOk = i == 0 || !char.IsLetterOrDigit(text[i - 1]) && text[i - 1] != '_';
                    bool afterOk = i + keyword.Length >= text.Length
                        || !char.IsLetterOrDigit(text[i + keyword.Length]) && text[i + keyword.Length] != '_';

                    if (beforeOk && afterOk)
                        return i;
                }
            }
            i++;
        }
        return -1;
    }

    internal static string StripComments(string text)
    {
        var sb = new System.Text.StringBuilder(text.Length);
        var state = ParseState.Normal;
        int i = 0;

        while (i < text.Length)
        {
            char c = text[i];

            switch (state)
            {
                case ParseState.Normal:
                    if (i + 1 < text.Length && c == '/' && text[i + 1] == '/')
                    {
                        sb.Append(' ');
                        state = ParseState.LineComment;
                        i += 2;
                    }
                    else if (c == '{')
                    {
                        sb.Append(' ');
                        state = ParseState.BlockBrace;
                        i++;
                    }
                    else if (i + 1 < text.Length && c == '(' && text[i + 1] == '*')
                    {
                        sb.Append(' ');
                        state = ParseState.BlockParen;
                        i += 2;
                    }
                    else if (c == '\'')
                    {
                        sb.Append(c);
                        state = ParseState.StringLiteral;
                        i++;
                    }
                    else
                    {
                        sb.Append(c);
                        i++;
                    }
                    break;

                case ParseState.LineComment:
                    if (c == '\n') { sb.Append('\n'); state = ParseState.Normal; }
                    i++;
                    break;

                case ParseState.BlockBrace:
                    if (c == '\n') sb.Append('\n');
                    if (c == '}') state = ParseState.Normal;
                    i++;
                    break;

                case ParseState.BlockParen:
                    if (c == '\n') sb.Append('\n');
                    if (i + 1 < text.Length && c == '*' && text[i + 1] == ')')
                    {
                        state = ParseState.Normal;
                        i += 2;
                    }
                    else i++;
                    break;

                case ParseState.StringLiteral:
                    sb.Append(c);
                    if (c == '\'')
                    {
                        if (i + 1 < text.Length && text[i + 1] == '\'')
                        {
                            sb.Append('\'');
                            i += 2;
                        }
                        else
                        {
                            state = ParseState.Normal;
                            i++;
                        }
                    }
                    else i++;
                    break;
            }
        }

        return sb.ToString();
    }

    private static bool IsKeyword(string name) =>
        name.Equals("uses", StringComparison.OrdinalIgnoreCase) ||
        name.Equals("in", StringComparison.OrdinalIgnoreCase) ||
        name.Equals("unit", StringComparison.OrdinalIgnoreCase) ||
        name.Equals("interface", StringComparison.OrdinalIgnoreCase) ||
        name.Equals("implementation", StringComparison.OrdinalIgnoreCase) ||
        name.Equals("initialization", StringComparison.OrdinalIgnoreCase) ||
        name.Equals("finalization", StringComparison.OrdinalIgnoreCase) ||
        name.Equals("begin", StringComparison.OrdinalIgnoreCase) ||
        name.Equals("end", StringComparison.OrdinalIgnoreCase);

    private enum ParseState { Normal, LineComment, BlockBrace, BlockParen, StringLiteral }
}
