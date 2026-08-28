unit uDomImport;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomImport = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomImport }

constructor TDomImport.Create;
begin
  inherited Create;
end;

destructor TDomImport.Destroy;
begin
  inherited Destroy;
end;

end.
