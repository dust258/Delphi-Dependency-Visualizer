unit uDomQuotation;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomQuotation = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomContract;

{ TDomQuotation }

constructor TDomQuotation.Create;
begin
  inherited Create;
end;

destructor TDomQuotation.Destroy;
begin
  inherited Destroy;
end;

end.
