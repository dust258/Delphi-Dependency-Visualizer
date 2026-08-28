unit uDomContactDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomContact;

type
  TDomContactDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomContactDetail }

constructor TDomContactDetail.Create;
begin
  inherited Create;
end;

destructor TDomContactDetail.Destroy;
begin
  inherited Destroy;
end;

end.
