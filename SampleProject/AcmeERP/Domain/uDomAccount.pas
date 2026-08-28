unit uDomAccount;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomAccount = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomAccount }

constructor TDomAccount.Create;
begin
  inherited Create;
end;

destructor TDomAccount.Destroy;
begin
  inherited Destroy;
end;

end.
