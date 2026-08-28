unit frmInventoryEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomInventoryDetail;

type
  TfrmInventoryEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmInventoryEdit: TfrmInventoryEdit;

implementation

uses
  dmInventory,
  uKernelUtils;

{$R *.dfm}

end.
