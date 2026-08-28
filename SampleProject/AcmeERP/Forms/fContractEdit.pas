unit fContractEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomContractDetail,
  frmContractEdit;

type
  TfContractEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fContractEdit: TfContractEdit;

implementation

uses
  uSvcContract,
  dmContract,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
