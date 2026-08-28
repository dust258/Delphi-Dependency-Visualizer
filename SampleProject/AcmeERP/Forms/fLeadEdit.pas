unit fLeadEdit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uDomLeadDetail,
  frmLeadEdit;

type
  TfLeadEdit = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fLeadEdit: TfLeadEdit;

implementation

uses
  uSvcLead,
  dmLead,
  uAppContext,
  uKernelExceptions;

{$R *.dfm}

end.
