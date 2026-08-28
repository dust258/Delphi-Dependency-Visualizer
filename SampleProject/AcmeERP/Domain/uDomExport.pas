unit uDomExport;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomExport = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomBatch;

{ TDomExport }

constructor TDomExport.Create;
begin
  inherited Create;
end;

destructor TDomExport.Destroy;
begin
  inherited Destroy;
end;

end.
