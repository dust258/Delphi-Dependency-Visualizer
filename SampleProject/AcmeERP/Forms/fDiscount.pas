unit fDiscount;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmDiscountList;

type
  TfDiscount = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDiscount: TfDiscount;

implementation

uses
  fDiscountEdit,
  fDiscountReport,
  dmDiscount,
  uSvcDiscount,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
