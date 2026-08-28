unit fBudgetEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomBudgetDetail,
  frmBudgetEdit;

type
  TfBudgetEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fBudgetEdit: TfBudgetEdit;

implementation

uses
  uSvcBudget,
  dmBudget,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
