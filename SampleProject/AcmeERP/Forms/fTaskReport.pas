unit fTaskReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfTaskReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTaskReport: TfTaskReport;

implementation

uses
  dmTask,
  uSvcTask,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
