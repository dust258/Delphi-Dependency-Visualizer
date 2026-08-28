unit uSvcAccount;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomAccount,
  uDomAccountDetail;

type
  TSvcAccount = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbAccountRepo,
  uKernelLog,
  uKernelEvents,
  uSvcContact;

{ TSvcAccount }

constructor TSvcAccount.Create;
begin
  inherited Create;
end;

destructor TSvcAccount.Destroy;
begin
  inherited Destroy;
end;

end.
