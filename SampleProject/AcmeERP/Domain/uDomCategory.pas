unit uDomCategory;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomCategory = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomCategory }

constructor TDomCategory.Create;
begin
  inherited Create;
end;

destructor TDomCategory.Destroy;
begin
  inherited Destroy;
end;

end.
