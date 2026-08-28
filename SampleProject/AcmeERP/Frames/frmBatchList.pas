unit frmBatchList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomBatch;

type
  TfrmBatchList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmBatchList: TfrmBatchList;

implementation

uses
  dmBatch,
  uSvcBatch,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
