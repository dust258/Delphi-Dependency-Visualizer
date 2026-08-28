unit uDomSetting;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes;

type
  TDomSetting = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDomAudit;

{ TDomSetting }

constructor TDomSetting.Create;
begin
  inherited Create;
end;

destructor TDomSetting.Destroy;
begin
  inherited Destroy;
end;

end.
