unit fReturnReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfReturnReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fReturnReport: TfReturnReport;

implementation

uses
  dmReturn,
  uSvcReturn,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
