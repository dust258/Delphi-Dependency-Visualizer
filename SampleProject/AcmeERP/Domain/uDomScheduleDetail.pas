unit uDomScheduleDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomSchedule;

type
  TDomScheduleDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomScheduleDetail }

constructor TDomScheduleDetail.Create;
begin
  inherited Create;
end;

destructor TDomScheduleDetail.Destroy;
begin
  inherited Destroy;
end;

end.
