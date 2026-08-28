unit fCustomer;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmCustomerList;

type
  TfCustomer = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCustomer: TfCustomer;

implementation

uses
  fCustomerEdit,
  fCustomerReport,
  dmCustomer,
  uSvcCustomer,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
