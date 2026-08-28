unit fOpportunity;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  frmOpportunityList;

type
  TfOpportunity = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fOpportunity: TfOpportunity;

implementation

uses
  fOpportunityEdit,
  fOpportunityReport,
  dmOpportunity,
  uSvcOpportunity,
  uAppContext,
  uKernelUtils;

{$R *.dfm}

end.
