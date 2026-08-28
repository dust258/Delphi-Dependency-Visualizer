unit uSvcDiscount;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomDiscount,
  uDomDiscountDetail;

type
  TSvcDiscount = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbDiscountRepo,
  uKernelLog,
  uKernelEvents,
  uSvcCategory;

{ TSvcDiscount }

constructor TSvcDiscount.Create;
begin
  inherited Create;
end;

destructor TSvcDiscount.Destroy;
begin
  inherited Destroy;
end;

end.
