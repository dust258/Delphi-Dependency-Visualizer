unit uDbRefundRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomRefund;

type
  TDbRefundRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbReturnRepo;

{ TDbRefundRepo }

constructor TDbRefundRepo.Create;
begin
  inherited Create;
end;

destructor TDbRefundRepo.Destroy;
begin
  inherited Destroy;
end;

end.
