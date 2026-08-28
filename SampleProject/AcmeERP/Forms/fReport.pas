unit fReport;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmReportList;

type
  TfReport = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fReport: TfReport;

implementation

uses
  fReportEdit,
  fReportReport,
  dmReport,
  uSvcReport,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
