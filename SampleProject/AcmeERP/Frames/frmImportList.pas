unit frmImportList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomImport;

type
  TfrmImportList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmImportList: TfrmImportList;

implementation

uses
  dmImport,
  uSvcImport,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
