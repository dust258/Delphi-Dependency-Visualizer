unit dmCategory;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  uDbConnection;

type
  TdmCategory = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dmCategory: TdmCategory;

implementation

uses
  uSvcCategory,
  uDbCategoryRepo,
  uKernelLog;

{$R *.dfm}

end.
