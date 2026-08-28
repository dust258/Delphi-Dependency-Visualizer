unit uDbConnection;

interface

uses
  System.SysUtils,
  System.Classes,
  uKernelConfig;

type
  TDbConnection = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelLog,
  uKernelExceptions;

{ TDbConnection }

constructor TDbConnection.Create;
begin
  inherited Create;
end;

destructor TDbConnection.Destroy;
begin
  inherited Destroy;
end;

end.
