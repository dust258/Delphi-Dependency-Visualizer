unit fSettings;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs;

type
  TfSettings = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fSettings: TfSettings;

implementation

uses
  dmMain,
  uAppContext,
  uKernelConfig,
  uKernelContainer,
  uKernelUtils;

{$R *.dfm}

end.
