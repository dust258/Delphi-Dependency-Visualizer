unit uDomReportDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomReport;

type
  TDomReportDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomReportDetail }

constructor TDomReportDetail.Create;
begin
  inherited Create;
end;

destructor TDomReportDetail.Destroy;
begin
  inherited Destroy;
end;

end.
