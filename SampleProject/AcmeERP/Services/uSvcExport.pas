unit uSvcExport;

interface

uses
  System.SysUtils,
  System.Classes,
  uDomExport,
  uDomExportDetail;

type
  TSvcExport = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uDbExportRepo,
  uKernelLog,
  uKernelEvents,
  uSvcImport;

{ TSvcExport }

constructor TSvcExport.Create;
begin
  inherited Create;
end;

destructor TSvcExport.Destroy;
begin
  inherited Destroy;
end;

end.
