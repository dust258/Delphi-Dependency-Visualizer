unit frmImportEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomImportDetail;

type
  TfrmImportEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmImportEdit: TfrmImportEdit;

implementation

uses
  dmImport,
  uKernelUtils;

{$R *.dfm}

end.
