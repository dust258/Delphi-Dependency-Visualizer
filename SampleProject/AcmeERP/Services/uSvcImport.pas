unit uSvcImport;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomImport,
  uDomImportDetail;

type
  TSvcImport = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbImportRepo,
  uKernelLog,
  uKernelEvents,
  uSvcExport;

{ TSvcImport }

constructor TSvcImport.Create;
begin
  inherited Create;
end;

destructor TSvcImport.Destroy;
begin
  inherited Destroy;
end;

end.
