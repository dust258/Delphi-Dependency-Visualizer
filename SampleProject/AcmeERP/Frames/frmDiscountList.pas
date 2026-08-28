unit frmDiscountList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDiscount;

type
  TfrmDiscountList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDiscountList: TfrmDiscountList;

implementation

uses
  dmDiscount,
  uSvcDiscount,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
