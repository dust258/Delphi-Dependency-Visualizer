unit frmContractList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomContract;

type
  TfrmContractList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContractList: TfrmContractList;

implementation

uses
  dmContract,
  uSvcContract,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
