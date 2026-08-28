unit uDbAssetRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomAsset;

type
  TDbAssetRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbDepreciationRepo;

{ TDbAssetRepo }

constructor TDbAssetRepo.Create;
begin
  inherited Create;
end;

destructor TDbAssetRepo.Destroy;
begin
  inherited Destroy;
end;

end.
