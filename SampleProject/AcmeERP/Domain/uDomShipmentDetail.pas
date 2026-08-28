unit uDomShipmentDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomShipment;

type
  TDomShipmentDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomShipmentDetail }

constructor TDomShipmentDetail.Create;
begin
  inherited Create;
end;

destructor TDomShipmentDetail.Destroy;
begin
  inherited Destroy;
end;

end.
