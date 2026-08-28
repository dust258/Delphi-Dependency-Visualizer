unit fImportEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomImportDetail,
  frmImportEdit;

type
  TfImportEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fImportEdit: TfImportEdit;

implementation

uses
  uSvcImport,
  dmImport,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
