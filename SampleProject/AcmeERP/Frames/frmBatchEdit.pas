unit frmBatchEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomBatchDetail;

type
  TfrmBatchEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmBatchEdit: TfrmBatchEdit;

implementation

uses
  dmBatch,
  uKernelUtils;

{$R *.dfm}

end.
