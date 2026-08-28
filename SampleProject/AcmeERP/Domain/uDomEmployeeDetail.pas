unit uDomEmployeeDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomEmployee;

type
  TDomEmployeeDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomEmployeeDetail }

constructor TDomEmployeeDetail.Create;
begin
  inherited Create;
end;

destructor TDomEmployeeDetail.Destroy;
begin
  inherited Destroy;
end;

end.
