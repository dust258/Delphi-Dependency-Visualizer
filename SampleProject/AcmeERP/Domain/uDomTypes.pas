unit uDomTypes;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TDomTypes = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation


{ TDomTypes }

constructor TDomTypes.Create;
begin
  inherited Create;
end;

destructor TDomTypes.Destroy;
begin
  inherited Destroy;
end;

end.
