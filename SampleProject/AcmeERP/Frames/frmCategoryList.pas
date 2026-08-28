unit frmCategoryList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomCategory;

type
  TfrmCategoryList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCategoryList: TfrmCategoryList;

implementation

uses
  dmCategory,
  uSvcCategory,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
