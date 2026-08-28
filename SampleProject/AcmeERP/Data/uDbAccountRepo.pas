unit uDbAccountRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomAccount;

type
  TDbAccountRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbContactRepo;

{ TDbAccountRepo }

constructor TDbAccountRepo.Create;
begin
  inherited Create;
end;

destructor TDbAccountRepo.Destroy;
begin
  inherited Destroy;
end;

end.
