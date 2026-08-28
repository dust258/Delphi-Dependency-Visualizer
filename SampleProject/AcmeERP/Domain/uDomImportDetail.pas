unit uDomImportDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomImport;

type
  TDomImportDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomImportDetail }

constructor TDomImportDetail.Create;
begin
  inherited Create;
end;

destructor TDomImportDetail.Destroy;
begin
  inherited Destroy;
end;

end.
