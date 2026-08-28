unit uDomAsset;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomAsset = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomAsset }

constructor TDomAsset.Create;
begin
  inherited Create;
end;

destructor TDomAsset.Destroy;
begin
  inherited Destroy;
end;

end.
