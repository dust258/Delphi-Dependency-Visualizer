unit uDbUserRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomUser;

type
  TDbUserRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDbUserRepo }

constructor TDbUserRepo.Create;
begin
  inherited Create;
end;

destructor TDbUserRepo.Destroy;
begin
  inherited Destroy;
end;

end.
