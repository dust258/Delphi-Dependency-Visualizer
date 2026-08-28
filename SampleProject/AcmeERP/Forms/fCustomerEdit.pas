unit fCustomerEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCustomerDetail,
  frmCustomerEdit;

type
  TfCustomerEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCustomerEdit: TfCustomerEdit;

implementation

uses
  uSvcCustomer,
  dmCustomer,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
