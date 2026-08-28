unit frmBudgetList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomBudget;

type
  TfrmBudgetList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmBudgetList: TfrmBudgetList;

implementation

uses
  dmBudget,
  uSvcBudget,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
