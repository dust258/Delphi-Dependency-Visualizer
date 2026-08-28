unit fAccountReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfAccountReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAccountReport: TfAccountReport;

implementation

uses
  dmAccount,
  uSvcAccount,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
