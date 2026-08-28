unit frmReturnList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomReturn;

type
  TfrmReturnList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmReturnList: TfrmReturnList;

implementation

uses
  dmReturn,
  uSvcReturn,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
