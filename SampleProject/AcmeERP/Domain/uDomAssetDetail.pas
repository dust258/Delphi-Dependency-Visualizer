unit uDomAssetDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomAsset;

type
  TDomAssetDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomAssetDetail }

constructor TDomAssetDetail.Create;
begin
  inherited Create;
end;

destructor TDomAssetDetail.Destroy;
begin
  inherited Destroy;
end;

end.
