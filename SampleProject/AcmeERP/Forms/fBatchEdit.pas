unit fBatchEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomBatchDetail,
  frmBatchEdit;

type
  TfBatchEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fBatchEdit: TfBatchEdit;

implementation

uses
  uSvcBatch,
  dmBatch,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
