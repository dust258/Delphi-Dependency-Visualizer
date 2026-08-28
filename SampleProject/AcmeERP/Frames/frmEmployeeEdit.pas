unit frmEmployeeEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomEmployeeDetail;

type
  TfrmEmployeeEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmEmployeeEdit: TfrmEmployeeEdit;

implementation

uses
  dmEmployee,
  uKernelUtils;

{$R *.dfm}

end.
