unit fDepreciation;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmDepreciationList;

type
  TfDepreciation = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDepreciation: TfDepreciation;

implementation

uses
  fDepreciationEdit,
  fDepreciationReport,
  dmDepreciation,
  uSvcDepreciation,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
