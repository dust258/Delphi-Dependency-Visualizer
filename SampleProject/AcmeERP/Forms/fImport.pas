unit fImport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmImportList;

type
  TfImport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fImport: TfImport;

implementation

uses
  fImportEdit,
  fImportReport,
  dmImport,
  uSvcImport,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
