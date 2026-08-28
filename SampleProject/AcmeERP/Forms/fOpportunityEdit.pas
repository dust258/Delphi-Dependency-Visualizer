unit fOpportunityEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomOpportunityDetail,
  frmOpportunityEdit;

type
  TfOpportunityEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fOpportunityEdit: TfOpportunityEdit;

implementation

uses
  uSvcOpportunity,
  dmOpportunity,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
