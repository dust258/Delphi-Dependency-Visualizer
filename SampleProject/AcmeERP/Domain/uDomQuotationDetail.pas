unit uDomQuotationDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomQuotation;

type
  TDomQuotationDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomQuotationDetail }

constructor TDomQuotationDetail.Create;
begin
  inherited Create;
end;

destructor TDomQuotationDetail.Destroy;
begin
  inherited Destroy;
end;

end.
