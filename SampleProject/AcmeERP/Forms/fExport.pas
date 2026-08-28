unit fExport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmExportList;

type
  TfExport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fExport: TfExport;

implementation

uses
  fExportEdit,
  fExportReport,
  dmExport,
  uSvcExport,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
