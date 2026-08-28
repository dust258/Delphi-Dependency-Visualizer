unit uDomReturnDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomReturn;

type
  TDomReturnDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomReturnDetail }

constructor TDomReturnDetail.Create;
begin
  inherited Create;
end;

destructor TDomReturnDetail.Destroy;
begin
  inherited Destroy;
end;

end.
