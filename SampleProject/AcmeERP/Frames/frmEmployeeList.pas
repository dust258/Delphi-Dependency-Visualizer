unit frmEmployeeList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomEmployee;

type
  TfrmEmployeeList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmEmployeeList: TfrmEmployeeList;

implementation

uses
  dmEmployee,
  uSvcEmployee,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
