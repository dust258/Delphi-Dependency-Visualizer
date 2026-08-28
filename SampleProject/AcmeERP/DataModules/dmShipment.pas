unit dmShipment;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmShipment = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmShipment: TdmShipment;

implementation

uses
  uSvcShipment,
  uDbShipmentRepo,
  uKernelLog;

{$R *.dfm}

end.
