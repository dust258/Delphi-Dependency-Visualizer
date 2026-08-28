unit uDomBatchDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomBatch;

type
  TDomBatchDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomBatchDetail }

constructor TDomBatchDetail.Create;
begin
  inherited Create;
end;

destructor TDomBatchDetail.Destroy;
begin
  inherited Destroy;
end;

end.
