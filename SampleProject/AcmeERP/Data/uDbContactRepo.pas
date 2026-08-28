unit uDbContactRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomContact;

type
  TDbContactRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbAccountRepo;

{ TDbContactRepo }

constructor TDbContactRepo.Create;
begin
  inherited Create;
end;

destructor TDbContactRepo.Destroy;
begin
  inherited Destroy;
end;

end.
