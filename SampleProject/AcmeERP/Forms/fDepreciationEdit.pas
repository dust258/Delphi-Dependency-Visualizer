unit fDepreciationEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomDepreciationDetail,
  frmDepreciationEdit;

type
  TfDepreciationEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fDepreciationEdit: TfDepreciationEdit;

implementation

uses
  uSvcDepreciation,
  dmDepreciation,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
