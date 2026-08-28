unit fCategoryReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTypes;

type
  TfCategoryReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCategoryReport: TfCategoryReport;

implementation

uses
  dmCategory,
  uSvcCategory,
  uAppContext,
  frmAuditLog,
  uKernelUtils;

{$R *.dfm}

end.
