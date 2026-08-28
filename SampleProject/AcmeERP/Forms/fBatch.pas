unit fBatch;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmBatchList;

type
  TfBatch = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fBatch: TfBatch;

implementation

uses
  fBatchEdit,
  fBatchReport,
  dmBatch,
  uSvcBatch,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
