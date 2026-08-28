unit uDomDocument;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomDocument = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomReminder;

{ TDomDocument }

constructor TDomDocument.Create;
begin
  inherited Create;
end;

destructor TDomDocument.Destroy;
begin
  inherited Destroy;
end;

end.
