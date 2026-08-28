unit uDomDepreciationDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomDepreciation;

type
  TDomDepreciationDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomDepreciationDetail }

constructor TDomDepreciationDetail.Create;
begin
  inherited Create;
end;

destructor TDomDepreciationDetail.Destroy;
begin
  inherited Destroy;
end;

end.
