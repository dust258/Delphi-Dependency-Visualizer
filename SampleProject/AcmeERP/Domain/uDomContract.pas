unit uDomContract;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomContract = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomQuotation;

{ TDomContract }

constructor TDomContract.Create;
begin
  inherited Create;
end;

destructor TDomContract.Destroy;
begin
  inherited Destroy;
end;

end.
