unit uDomTimesheetDetail;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomTypes,
  uDomTimesheet;

type
  TDomTimesheetDetail = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils;

{ TDomTimesheetDetail }

constructor TDomTimesheetDetail.Create;
begin
  inherited Create;
end;

destructor TDomTimesheetDetail.Destroy;
begin
  inherited Destroy;
end;

end.
