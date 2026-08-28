unit uSvcCategory;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomCategory,
  uDomCategoryDetail;

type
  TSvcCategory = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbCategoryRepo,
  uKernelLog,
  uKernelEvents,
  uSvcDiscount;

{ TSvcCategory }

constructor TSvcCategory.Create;
begin
  inherited Create;
end;

destructor TSvcCategory.Destroy;
begin
  inherited Destroy;
end;

end.
