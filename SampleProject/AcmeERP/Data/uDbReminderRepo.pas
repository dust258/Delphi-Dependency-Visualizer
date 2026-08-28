unit uDbReminderRepo;

interface

uses
  System.SysUtils,
  System.Classes,
  uDbRepository,
  uDomReminder;

type
  TDbReminderRepo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uKernelUtils,
  uDbDocumentRepo;

{ TDbReminderRepo }

constructor TDbReminderRepo.Create;
begin
  inherited Create;
end;

destructor TDbReminderRepo.Destroy;
begin
  inherited Destroy;
end;

end.
