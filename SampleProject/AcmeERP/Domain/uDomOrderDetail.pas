unit uDomOrderDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomOrder;

type
  TDomOrderDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomOrderDetail }

constructor TDomOrderDetail.Create;
begin
  inherited Create;
end;

destructor TDomOrderDetail.Destroy;
begin
  inherited Destroy;
end;

end.
