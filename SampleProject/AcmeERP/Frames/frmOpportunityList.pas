unit frmOpportunityList;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomOpportunity;

type
  TfrmOpportunityList = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmOpportunityList: TfrmOpportunityList;

implementation

uses
  dmOpportunity,
  uSvcOpportunity,
  uKernelUtils,
  uKernelEvents;

{$R *.dfm}

end.
