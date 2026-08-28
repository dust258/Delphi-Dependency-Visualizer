unit fCategoryEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCategoryDetail,
  frmCategoryEdit;

type
  TfCategoryEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fCategoryEdit: TfCategoryEdit;

implementation

uses
  uSvcCategory,
  dmCategory,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
