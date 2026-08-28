unit uDomBudget;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomBudget = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomBudget }

constructor TDomBudget.Create;
begin
  inherited Create;
end;

destructor TDomBudget.Destroy;
begin
  inherited Destroy;
end;

end.
