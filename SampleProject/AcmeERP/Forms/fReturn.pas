unit fReturn;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmReturnList;

type
  TfReturn = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fReturn: TfReturn;

implementation

uses
  fReturnEdit,
  fReturnReport,
  dmReturn,
  uSvcReturn,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
