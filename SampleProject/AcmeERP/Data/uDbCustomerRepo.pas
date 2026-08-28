unit uDbCustomerRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomCustomer;

type
  TDbCustomerRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbOrderRepo;

{ TDbCustomerRepo }

constructor TDbCustomerRepo.Create;
begin
  inherited Create;
end;

destructor TDbCustomerRepo.Destroy;
begin
  inherited Destroy;
end;

end.
