unit uSvcQuotation;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomQuotation,
  uDomQuotationDetail;

type
  TSvcQuotation = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbQuotationRepo,
  uKernelLog,
  uKernelEvents,
  uSvcContract;

{ TSvcQuotation }

constructor TSvcQuotation.Create;
begin
  inherited Create;
end;

destructor TSvcQuotation.Destroy;
begin
  inherited Destroy;
end;

end.
