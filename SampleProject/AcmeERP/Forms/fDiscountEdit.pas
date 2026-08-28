unit fDiscountEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDiscountDetail,
  frmDiscountEdit;

type
  TfDiscountEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDiscountEdit: TfDiscountEdit;

implementation

uses
  uSvcDiscount,
  dmDiscount,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
