unit dmDiscount;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmDiscount = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmDiscount: TdmDiscount;

implementation

uses
  uSvcDiscount,
  uDbDiscountRepo,
  uKernelLog;

{$R *.dfm}

end.
