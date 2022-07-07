unit uDlgDefaults;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls,
  uImageConfig;

type
  TFrmDefaultConfig = class(TForm)
    GroupBox1: TGroupBox;
    lbQuality: TLabel;
    lbTargetKB: TLabel;
    seQuality: TSpinEdit;
    seTargetKBs: TSpinEdit;
    tbQuality: TTrackBar;
    cbCompress: TCheckBox;
    GroupBox3: TGroupBox;
    lbMaxHeightPx: TLabel;
    lbMaxWidthPx: TLabel;
    lbResampling: TLabel;
    lbRotation: TLabel;
    rbByHeight: TRadioButton;
    rbByWidth: TRadioButton;
    seMaxWidthPx: TSpinEdit;
    seMaxHeightPx: TSpinEdit;
    cbResampleMode: TComboBox;
    cbRotateAmount: TComboBox;
    GroupBox2: TGroupBox;
    lbPrefix: TLabel;
    lbDescription: TLabel;
    ebPrefix: TEdit;
    ebDescription: TEdit;
    cbApplyGraphics: TCheckBox;
    cbCreateJSONFile: TCheckBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Button2: TButton;
    btnOK: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fOwnsImageConfig: boolean;
    fImageConfig: TImageConfig;
    fRecordModified: boolean;
    procedure ObjToForm;
    procedure FormToObj;
    procedure SetImageConfig(const Value: TImageConfig);
  public
    { Public declarations }
    property RecordModified: boolean read fRecordModified;
    property ImageConfig: TImageConfig read fImageConfig write SetImageConfig;
  end;

var
  FrmDefaultConfig: TFrmDefaultConfig;

implementation

uses
  uJPEGCompressor, uConstants;

{$R *.dfm}

procedure TFrmDefaultConfig.btnOKClick(Sender: TObject);
begin
  inherited;
  FormToObj;
  fRecordModified := true;
  Close;
end;

procedure TFrmDefaultConfig.Button2Click(Sender: TObject);
begin
  inherited;
  fRecordModified := false;
  Close;
end;

procedure TFrmDefaultConfig.FormCreate(Sender: TObject);
begin
  inherited;
  fOwnsImageConfig := true;
  fImageConfig := TImageConfig.Create;
end;

procedure TFrmDefaultConfig.FormDestroy(Sender: TObject);
begin
  if fOwnsImageConfig and
     Assigned(fImageConfig) then
    fImageConfig.Free;
  inherited;
end;

procedure TFrmDefaultConfig.FormShow(Sender: TObject);
begin
  ObjToForm;
  inherited;
end;

procedure TFrmDefaultConfig.ObjToForm;
begin
  if Assigned(fImageConfig) then begin
    with fImageConfig do begin
      cbCompress.Checked := Compress;
      seQuality.Value := Quality;
      tbQuality.Position := Quality;
      seTargetKBs.Value := TargetKB;
      cbCreateJSONFile.Checked := AddToJSON;
      ebDescription.Text := Description;
      ebPrefix.Text := SourcePrefix;
      cbApplyGraphics.Checked := ApplyGraphics;
      rbByWidth.Checked := ShrinkByWidth;
      rbByHeight.Checked := not ShrinkByWidth;
      cbRotateAmount.ItemIndex := integer(RotateAmount);
      cbResampleMode.ItemIndex := integer(ResampleMode);
      if rbByWidth.Checked then
        seMaxWidthPx.Value := ShrinkByValue
      else
        seMaxHeightPx.Value := ShrinkByValue;
    end;
  end;
end;

procedure TFrmDefaultConfig.FormToObj;
begin
  with fImageConfig do begin
    Compress := cbCompress.Checked;
    Quality := seQuality.Value;
    TargetKB := seTargetKBs.Value;
    AddToJSON := cbCreateJSONFile.Checked;
    Description := ebDescription.Text;
    SourcePrefix := ebPrefix.Text;
    ApplyGraphics := cbApplyGraphics.Checked;
    ShrinkByWidth := rbByWidth.Checked;
    RotateAmount := TRotateAmount(cbRotateAmount.ItemIndex);
    ResampleMode := TResampleMode(cbResampleMode.ItemIndex);
    if ShrinkByWidth then
      ShrinkByValue := seMaxWidthPx.Value
    else
      ShrinkByValue := seMaxHeightPx.Value;
  end;
end;

procedure TFrmDefaultConfig.SetImageConfig(const Value: TImageConfig);
begin
  if Assigned(fImageConfig) then begin
    fImageConfig.Free;
    fOwnsImageConfig := false;
  end;
  fImageConfig := Value;
end;

end.
