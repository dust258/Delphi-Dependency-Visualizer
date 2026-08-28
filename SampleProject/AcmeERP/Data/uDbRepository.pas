unit uDbRepository;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbConnection,
  uDomTypes;

type
  TDbRepository = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelLog;

{ TDbRepository }

constructor TDbRepository.Create;
begin
  inherited Create;
end;

destructor TDbRepository.Destroy;
begin
  inherited Destroy;
end;

end.
