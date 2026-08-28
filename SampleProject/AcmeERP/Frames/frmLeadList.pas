unit frmLeadList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomLead;

type
  TfrmLeadList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmLeadList: TfrmLeadList;

implementation

uses
  dmLead,
  uSvcLead,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
