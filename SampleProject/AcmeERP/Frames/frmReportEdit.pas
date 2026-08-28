unit frmReportEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomReportDetail;

type
  TfrmReportEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmReportEdit: TfrmReportEdit;

implementation

uses
  dmReport,
  uKernelUtils;

{$R *.dfm}

end.
