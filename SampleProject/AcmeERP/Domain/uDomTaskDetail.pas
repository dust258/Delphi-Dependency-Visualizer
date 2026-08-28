unit uDomTaskDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomTask;

type
  TDomTaskDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomTaskDetail }

constructor TDomTaskDetail.Create;
begin
  inherited Create;
end;

destructor TDomTaskDetail.Destroy;
begin
  inherited Destroy;
end;

end.
