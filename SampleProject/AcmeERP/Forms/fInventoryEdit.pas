unit fInventoryEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomInventoryDetail,
  frmInventoryEdit;

type
  TfInventoryEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fInventoryEdit: TfInventoryEdit;

implementation

uses
  uSvcInventory,
  dmInventory,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
