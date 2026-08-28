unit uDomProjectDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomProject;

type
  TDomProjectDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomProjectDetail }

constructor TDomProjectDetail.Create;
begin
  inherited Create;
end;

destructor TDomProjectDetail.Destroy;
begin
  inherited Destroy;
end;

end.
