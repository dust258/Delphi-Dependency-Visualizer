unit uDbDocumentRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomDocument;

type
  TDbDocumentRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbReminderRepo;

{ TDbDocumentRepo }

constructor TDbDocumentRepo.Create;
begin
  inherited Create;
end;

destructor TDbDocumentRepo.Destroy;
begin
  inherited Destroy;
end;

end.
