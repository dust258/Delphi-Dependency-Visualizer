unit uSvcDepreciation;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomDepreciation,
  uDomDepreciationDetail;

type
  TSvcDepreciation = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbDepreciationRepo,
  uKernelLog,
  uKernelEvents,
  uSvcAsset;

{ TSvcDepreciation }

constructor TSvcDepreciation.Create;
begin
  inherited Create;
end;

destructor TSvcDepreciation.Destroy;
begin
  inherited Destroy;
end;

end.
