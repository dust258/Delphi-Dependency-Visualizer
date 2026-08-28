unit fAssetReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfAssetReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAssetReport: TfAssetReport;

implementation

uses
  dmAsset,
  uSvcAsset,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
