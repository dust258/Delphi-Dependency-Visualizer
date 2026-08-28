unit frmProjectEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomProjectDetail;

type
  TfrmProjectEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmProjectEdit: TfrmProjectEdit;

implementation

uses
  dmProject,
  uKernelUtils;

{$R *.dfm}

end.
