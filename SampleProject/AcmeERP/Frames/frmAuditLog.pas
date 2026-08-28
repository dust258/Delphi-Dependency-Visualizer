unit frmAuditLog;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfrmAuditLog = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAuditLog: TfrmAuditLog;

implementation

uses
  uKernelLog,
  uKernelEvents;

{$R *.dfm}

end.
