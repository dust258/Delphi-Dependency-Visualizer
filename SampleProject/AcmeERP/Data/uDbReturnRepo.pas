unit uDbReturnRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomReturn;

type
  TDbReturnRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbRefundRepo;

{ TDbReturnRepo }

constructor TDbReturnRepo.Create;
begin
  inherited Create;
end;

destructor TDbReturnRepo.Destroy;
begin
  inherited Destroy;
end;

end.
