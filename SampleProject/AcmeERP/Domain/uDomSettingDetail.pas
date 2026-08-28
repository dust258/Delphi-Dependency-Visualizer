unit uDomSettingDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomSetting;

type
  TDomSettingDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomSettingDetail }

constructor TDomSettingDetail.Create;
begin
  inherited Create;
end;

destructor TDomSettingDetail.Destroy;
begin
  inherited Destroy;
end;

end.
