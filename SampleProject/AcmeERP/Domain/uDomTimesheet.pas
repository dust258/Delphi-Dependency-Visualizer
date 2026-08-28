unit uDomTimesheet;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomTimesheet = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomExpense;

{ TDomTimesheet }

constructor TDomTimesheet.Create;
begin
  inherited Create;
end;

destructor TDomTimesheet.Destroy;
begin
  inherited Destroy;
end;

end.
