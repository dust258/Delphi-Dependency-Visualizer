unit dmContact;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmContact = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmContact: TdmContact;

implementation

uses
  uSvcContact,
  uDbContactRepo,
  uKernelLog;

{$R *.dfm}

end.
