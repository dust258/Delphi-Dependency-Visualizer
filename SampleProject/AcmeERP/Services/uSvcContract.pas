unit uSvcContract;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomContract,
  uDomContractDetail;

type
  TSvcContract = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbContractRepo,
  uKernelLog,
  uKernelEvents,
  uSvcQuotation;

{ TSvcContract }

constructor TSvcContract.Create;
begin
  inherited Create;
end;

destructor TSvcContract.Destroy;
begin
  inherited Destroy;
end;

end.
