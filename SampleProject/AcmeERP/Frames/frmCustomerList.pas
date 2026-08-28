unit frmCustomerList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCustomer;

type
  TfrmCustomerList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCustomerList: TfrmCustomerList;

implementation

uses
  dmCustomer,
  uSvcCustomer,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
