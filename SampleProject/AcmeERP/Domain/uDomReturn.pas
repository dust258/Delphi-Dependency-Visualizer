unit uDomReturn;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomReturn = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomReturn }

constructor TDomReturn.Create;
begin
  inherited Create;
end;

destructor TDomReturn.Destroy;
begin
  inherited Destroy;
end;

end.
