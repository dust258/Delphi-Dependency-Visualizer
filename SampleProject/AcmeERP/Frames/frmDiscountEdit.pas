unit frmDiscountEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDiscountDetail;

type
  TfrmDiscountEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDiscountEdit: TfrmDiscountEdit;

implementation

uses
  dmDiscount,
  uKernelUtils;

{$R *.dfm}

end.
