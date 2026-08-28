unit fTaxEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTaxDetail,
  frmTaxEdit;

type
  TfTaxEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTaxEdit: TfTaxEdit;

implementation

uses
  uSvcTax,
  dmTax,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
