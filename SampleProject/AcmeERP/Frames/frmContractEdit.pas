unit frmContractEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomContractDetail;

type
  TfrmContractEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContractEdit: TfrmContractEdit;

implementation

uses
  dmContract,
  uKernelUtils;

{$R *.dfm}

end.
