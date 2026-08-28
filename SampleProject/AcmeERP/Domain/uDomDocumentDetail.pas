unit uDomDocumentDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomDocument;

type
  TDomDocumentDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomDocumentDetail }

constructor TDomDocumentDetail.Create;
begin
  inherited Create;
end;

destructor TDomDocumentDetail.Destroy;
begin
  inherited Destroy;
end;

end.
