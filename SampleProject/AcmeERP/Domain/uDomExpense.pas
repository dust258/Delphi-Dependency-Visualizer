unit uDomExpense;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomExpense = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomTimesheet;

{ TDomExpense }

constructor TDomExpense.Create;
begin
  inherited Create;
end;

destructor TDomExpense.Destroy;
begin
  inherited Destroy;
end;

end.
