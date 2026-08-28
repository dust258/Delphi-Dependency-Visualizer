unit frmLeadEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomLeadDetail;

type
  TfrmLeadEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmLeadEdit: TfrmLeadEdit;

implementation

uses
  dmLead,
  uKernelUtils;

{$R *.dfm}

end.
