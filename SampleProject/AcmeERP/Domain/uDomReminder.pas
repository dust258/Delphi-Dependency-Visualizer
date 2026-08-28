unit uDomReminder;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomReminder = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomDocument;

{ TDomReminder }

constructor TDomReminder.Create;
begin
  inherited Create;
end;

destructor TDomReminder.Destroy;
begin
  inherited Destroy;
end;

end.
