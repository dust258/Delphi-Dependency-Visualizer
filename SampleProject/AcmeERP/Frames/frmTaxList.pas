unit frmTaxList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTax;

type
  TfrmTaxList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTaxList: TfrmTaxList;

implementation

uses
  dmTax,
  uSvcTax,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
