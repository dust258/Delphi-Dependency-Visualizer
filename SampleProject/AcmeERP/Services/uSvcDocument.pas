unit uSvcDocument;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomDocument,
  uDomDocumentDetail;

type
  TSvcDocument = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbDocumentRepo,
  uKernelLog,
  uKernelEvents,
  uSvcReminder;

{ TSvcDocument }

constructor TSvcDocument.Create;
begin
  inherited Create;
end;

destructor TSvcDocument.Destroy;
begin
  inherited Destroy;
end;

end.
