unit frmInventoryList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomInventory;

type
  TfrmInventoryList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmInventoryList: TfrmInventoryList;

implementation

uses
  dmInventory,
  uSvcInventory,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
