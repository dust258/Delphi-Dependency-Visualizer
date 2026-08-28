unit uSvcAuth;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomUser;

type
  TSvcAuth = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbUserRepo,
  uKernelLog,
  uKernelConfig;

{ TSvcAuth }

constructor TSvcAuth.Create;
begin
  inherited Create;
end;

destructor TSvcAuth.Destroy;
begin
  inherited Destroy;
end;

end.
