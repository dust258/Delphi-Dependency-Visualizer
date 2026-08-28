unit frmTaskEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomTaskDetail;

type
  TfrmTaskEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTaskEdit: TfrmTaskEdit;

implementation

uses
  dmTask,
  uKernelUtils;

{$R *.dfm}

end.
