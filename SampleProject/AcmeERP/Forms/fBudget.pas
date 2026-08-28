unit fBudget;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmBudgetList;

type
  TfBudget = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fBudget: TfBudget;

implementation

uses
  fBudgetEdit,
  fBudgetReport,
  dmBudget,
  uSvcBudget,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
