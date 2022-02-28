unit UnitCropComment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ComCtrls;

type
  TFormCrop = class(TForm)
    pgc1: TPageControl;
    tsPas: TTabSheet;
    tsCpp: TTabSheet;
    mmoPas: TMemo;
    mmoPasRes: TMemo;
    mmoCpp: TMemo;
    mmoCppRes: TMemo;
    btnPasCrop: TSpeedButton;
    btnCppCrop: TSpeedButton;
    procedure btnPasCropClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCrop: TFormCrop;

implementation

uses
  CnSourceCropper;

{$R *.DFM}

procedure TFormCrop.btnPasCropClick(Sender: TObject);
var
  Cropper: TCnPasCropper;
  InStr, OutStr: TStringStream;
begin
  Cropper := TCnPasCropper.Create;
  InStr := TStringStream.Create(mmoPas.Lines.Text);
  OutStr := TStringStream.Create('');

  Cropper.InStream := InStr;
  Cropper.OutStream := OutStr;
  Cropper.Parse;

  mmoPasRes.Lines.Clear;
  mmoPasRes.Lines.Text := OutStr.DataString;
  OutStr.Free;
  InStr.Free;
  Cropper.Free;
end;

end.