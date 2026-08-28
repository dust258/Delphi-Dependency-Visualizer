unit fAbout;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs;

type
  TfAbout = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAbout: TfAbout;

implementation

uses
  uKernelConfig,
  uKernelUtils,
  uAppContext;

{$R *.dfm}

end.
