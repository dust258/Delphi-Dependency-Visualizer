unit uSvcBatch;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomBatch,
  uDomBatchDetail;

type
  TSvcBatch = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbBatchRepo,
  uKernelLog,
  uKernelEvents,
  uSvcSchedule;

{ TSvcBatch }

constructor TSvcBatch.Create;
begin
  inherited Create;
end;

destructor TSvcBatch.Destroy;
begin
  inherited Destroy;
end;

end.
