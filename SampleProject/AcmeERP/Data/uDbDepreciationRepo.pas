unit uDbDepreciationRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomDepreciation;

type
  TDbDepreciationRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbAssetRepo;

{ TDbDepreciationRepo }

constructor TDbDepreciationRepo.Create;
begin
  inherited Create;
end;

destructor TDbDepreciationRepo.Destroy;
begin
  inherited Destroy;
end;

end.
