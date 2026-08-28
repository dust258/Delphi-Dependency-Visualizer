unit uDbExportRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomExport;

type
  TDbExportRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbImportRepo;

{ TDbExportRepo }

constructor TDbExportRepo.Create;
begin
  inherited Create;
end;

destructor TDbExportRepo.Destroy;
begin
  inherited Destroy;
end;

end.
