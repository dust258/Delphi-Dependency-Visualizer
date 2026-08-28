unit uDomAccountDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomAccount;

type
  TDomAccountDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomAccountDetail }

constructor TDomAccountDetail.Create;
begin
  inherited Create;
end;

destructor TDomAccountDetail.Destroy;
begin
  inherited Destroy;
end;

end.
