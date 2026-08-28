unit frmDepreciationList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDepreciation;

type
  TfrmDepreciationList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDepreciationList: TfrmDepreciationList;

implementation

uses
  dmDepreciation,
  uSvcDepreciation,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
