unit uDomExportDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomExport;

type
  TDomExportDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomExportDetail }

constructor TDomExportDetail.Create;
begin
  inherited Create;
end;

destructor TDomExportDetail.Destroy;
begin
  inherited Destroy;
end;

end.
