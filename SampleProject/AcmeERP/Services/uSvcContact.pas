unit uSvcContact;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomContact,
  uDomContactDetail;

type
  TSvcContact = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbContactRepo,
  uKernelLog,
  uKernelEvents,
  uSvcAccount;

{ TSvcContact }

constructor TSvcContact.Create;
begin
  inherited Create;
end;

destructor TSvcContact.Destroy;
begin
  inherited Destroy;
end;

end.
