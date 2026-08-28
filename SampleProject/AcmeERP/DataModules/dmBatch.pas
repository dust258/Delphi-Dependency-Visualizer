unit dmBatch;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmBatch = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmBatch: TdmBatch;

implementation

uses
  uSvcBatch,
  uDbBatchRepo,
  uKernelLog;

{$R *.dfm}

end.
