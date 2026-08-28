unit fExportEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomExportDetail,
  frmExportEdit;

type
  TfExportEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fExportEdit: TfExportEdit;

implementation

uses
  uSvcExport,
  dmExport,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
