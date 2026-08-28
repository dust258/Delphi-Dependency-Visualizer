unit uDbOrderRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomOrder;

type
  TDbOrderRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbCustomerRepo;

{ TDbOrderRepo }

constructor TDbOrderRepo.Create;
begin
  inherited Create;
end;

destructor TDbOrderRepo.Destroy;
begin
  inherited Destroy;
end;

end.
