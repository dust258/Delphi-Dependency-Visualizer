unit frmOpportunityEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomOpportunityDetail;

type
  TfrmOpportunityEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmOpportunityEdit: TfrmOpportunityEdit;

implementation

uses
  dmOpportunity,
  uKernelUtils;

{$R *.dfm}

end.
