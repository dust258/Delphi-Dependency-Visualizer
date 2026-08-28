unit uAppContext;

interface

uses
  System.SysUtils,
  System.Classes,
  fMain;

type
  TAppContext = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelLog,
  uKernelConfig;

{ TAppContext }

constructor TAppContext.Create;
begin
  inherited Create;
end;

destructor TAppContext.Destroy;
begin
  inherited Destroy;
end;

end.
