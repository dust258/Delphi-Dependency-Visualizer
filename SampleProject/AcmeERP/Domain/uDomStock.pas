unit uDomStock;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomStock = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomStock }

constructor TDomStock.Create;
begin
  inherited Create;
end;

destructor TDomStock.Destroy;
begin
  inherited Destroy;
end;

end.
