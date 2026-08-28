unit fContract;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmContractList;

type
  TfContract = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fContract: TfContract;

implementation

uses
  fContractEdit,
  fContractReport,
  dmContract,
  uSvcContract,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
