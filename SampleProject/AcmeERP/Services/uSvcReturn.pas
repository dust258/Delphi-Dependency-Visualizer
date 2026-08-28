unit uSvcReturn;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomReturn,
  uDomReturnDetail;

type
  TSvcReturn = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbReturnRepo,
  uKernelLog,
  uKernelEvents,
  uSvcRefund;

{ TSvcReturn }

constructor TSvcReturn.Create;
begin
  inherited Create;
end;

destructor TSvcReturn.Destroy;
begin
  inherited Destroy;
end;

end.
