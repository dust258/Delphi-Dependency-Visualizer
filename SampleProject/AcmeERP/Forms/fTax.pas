unit fTax;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmTaxList;

type
  TfTax = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fTax: TfTax;

implementation

uses
  fTaxEdit,
  fTaxReport,
  dmTax,
  uSvcTax,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
