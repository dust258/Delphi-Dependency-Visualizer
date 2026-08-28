unit uDomContact;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomContact = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomOpportunity;

{ TDomContact }

constructor TDomContact.Create;
begin
  inherited Create;
end;

destructor TDomContact.Destroy;
begin
  inherited Destroy;
end;

end.
