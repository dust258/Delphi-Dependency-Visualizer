unit fInventory;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmInventoryList;

type
  TfInventory = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fInventory: TfInventory;

implementation

uses
  fInventoryEdit,
  fInventoryReport,
  dmInventory,
  uSvcInventory,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
