using DelphiVisualizer.Models;
using System.IO;
using System.Text.RegularExpressions;

namespace DelphiVisualizer.Parser;

public static class DprParser
{
    private static readonly Regex UnitEntryRegex =
        new(@"(\w+)\s*(?:in\s*'([^']+)')?", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    public static Dictionary<string, ProjectUnit> Parse(string dprPath)
    {
        var projectDir = Path.GetDirectoryName(dprPath) ?? "";
        var content = File.ReadAllText(dprPath);
        var stripped = StripComments(content);

        var usesBlock = ExtractTopLevelUsesBlock(stripped);
        var units = new Dictionary<string, ProjectUnit>(StringComparer.OrdinalIgnoreCase);

        foreach (Match m in UnitEntryRegex.Matches(usesBlock))
        {
            var name = m.Groups[1].Value.Trim();
            if (string.IsNullOrEmpty(name) || IsKeyword(name))
                continue;

            var relPath = m.Groups[2].Success ? m.Groups[2].Value.Trim() : name + ".pas";
            var absPath = Path.GetFullPath(Path.Combine(projectDir, relPath));

            units[name] = new ProjectUnit
            {
                Name = name,
                FilePath = relPath,
                AbsolutePath = absPath,
                FileFound = File.Exists(absPath)
            };
        }

        return units;
    }

    private static string ExtractTopLevelUsesBlock(string text)
    {
        // Find "uses" at top level (not inside type/var/const blocks)
        var usesMatch = Regex.Match(text, @"\bprogram\b.*?\buses\b", RegexOptions.IgnoreCase | RegexOptions.Singleline);
        if (!usesMatch.Success)
        {
            // Fallback: just find first "uses"
            usesMatch = Regex.Match(text, @"\buses\b", RegexOptions.IgnoreCase);
            if (!usesMatch.Success) return "";
        }

        var start = text.IndexOf("uses", usesMatch.Index, StringComparison.OrdinalIgnoreCase) + 4;
        var end = text.IndexOf(';', start);
        if (end < 0) return "";

        return text[start..end];
    }

    private static string StripComments(string text)
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

    private static bool IsKeyword(string name)
    {
        return name.Equals("uses", StringComparison.OrdinalIgnoreCase)
            || name.Equals("in", StringComparison.OrdinalIgnoreCase)
            || name.Equals("begin", StringComparison.OrdinalIgnoreCase)
            || name.Equals("end", StringComparison.OrdinalIgnoreCase);
    }

    private enum ParseState { Normal, LineComment, BlockBrace, BlockParen, StringLiteral }
}
