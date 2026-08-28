unit frmCustomerEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCustomerDetail;

type
  TfrmCustomerEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCustomerEdit: TfrmCustomerEdit;

implementation

uses
  dmCustomer,
  uKernelUtils;

{$R *.dfm}

end.
