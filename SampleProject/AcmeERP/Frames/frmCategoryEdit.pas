unit frmCategoryEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCategoryDetail;

type
  TfrmCategoryEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCategoryEdit: TfrmCategoryEdit;

implementation

uses
  dmCategory,
  uKernelUtils;

{$R *.dfm}

end.
