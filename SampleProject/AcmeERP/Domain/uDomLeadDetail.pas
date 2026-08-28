unit uDomLeadDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomLead;

type
  TDomLeadDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomLeadDetail }

constructor TDomLeadDetail.Create;
begin
  inherited Create;
end;

destructor TDomLeadDetail.Destroy;
begin
  inherited Destroy;
end;

end.
