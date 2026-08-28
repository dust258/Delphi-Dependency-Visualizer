unit uDomBatch;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomBatch = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomExport;

{ TDomBatch }

constructor TDomBatch.Create;
begin
  inherited Create;
end;

destructor TDomBatch.Destroy;
begin
  inherited Destroy;
end;

end.
