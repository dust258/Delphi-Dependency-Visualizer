unit frmExportList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomExport;

type
  TfrmExportList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmExportList: TfrmExportList;

implementation

uses
  dmExport,
  uSvcExport,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
