unit fCategory;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmCategoryList;

type
  TfCategory = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCategory: TfCategory;

implementation

uses
  fCategoryEdit,
  fCategoryReport,
  dmCategory,
  uSvcCategory,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
