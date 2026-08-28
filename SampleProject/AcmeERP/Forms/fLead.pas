unit fLead;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmLeadList;

type
  TfLead = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fLead: TfLead;

implementation

uses
  fLeadEdit,
  fLeadReport,
  dmLead,
  uSvcLead,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
