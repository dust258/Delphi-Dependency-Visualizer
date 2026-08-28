unit fReportEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomReportDetail,
  frmReportEdit;

type
  TfReportEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fReportEdit: TfReportEdit;

implementation

uses
  uSvcReport,
  dmReport,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
