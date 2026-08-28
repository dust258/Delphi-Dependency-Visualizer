unit uDbImportRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomImport;

type
  TDbImportRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbExportRepo;

{ TDbImportRepo }

constructor TDbImportRepo.Create;
begin
  inherited Create;
end;

destructor TDbImportRepo.Destroy;
begin
  inherited Destroy;
end;

end.
