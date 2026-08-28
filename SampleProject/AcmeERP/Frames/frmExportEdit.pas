unit frmExportEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomExportDetail;

type
  TfrmExportEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmExportEdit: TfrmExportEdit;

implementation

uses
  dmExport,
  uKernelUtils;

{$R *.dfm}

end.
