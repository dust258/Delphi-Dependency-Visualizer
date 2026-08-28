unit uDomCategoryDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomCategory;

type
  TDomCategoryDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomCategoryDetail }

constructor TDomCategoryDetail.Create;
begin
  inherited Create;
end;

destructor TDomCategoryDetail.Destroy;
begin
  inherited Destroy;
end;

end.
