unit frmBudgetEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomBudgetDetail;

type
  TfrmBudgetEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmBudgetEdit: TfrmBudgetEdit;

implementation

uses
  dmBudget,
  uKernelUtils;

{$R *.dfm}

end.
