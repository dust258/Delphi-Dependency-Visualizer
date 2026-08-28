unit frmReportList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomReport;

type
  TfrmReportList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmReportList: TfrmReportList;

implementation

uses
  dmReport,
  uSvcReport,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
