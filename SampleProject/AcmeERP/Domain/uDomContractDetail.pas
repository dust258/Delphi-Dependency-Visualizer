unit uDomContractDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomContract;

type
  TDomContractDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomContractDetail }

constructor TDomContractDetail.Create;
begin
  inherited Create;
end;

destructor TDomContractDetail.Destroy;
begin
  inherited Destroy;
end;

end.
