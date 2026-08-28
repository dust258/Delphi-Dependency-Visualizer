unit uSvcAsset;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomAsset,
  uDomAssetDetail;

type
  TSvcAsset = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbAssetRepo,
  uKernelLog,
  uKernelEvents,
  uSvcDepreciation;

{ TSvcAsset }

constructor TSvcAsset.Create;
begin
  inherited Create;
end;

destructor TSvcAsset.Destroy;
begin
  inherited Destroy;
end;

end.
