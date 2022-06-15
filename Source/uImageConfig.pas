unit uImageConfig;

interface

uses
  uJPEGCompressor;

type
  TImageConfig = class(TObject)
  strict private
    fPreviewModified: boolean;
    fPreviewCompression: boolean;
    fStretch: boolean;
    fFilename: string;
    fAddToJSON: boolean;
    fSourcePrefix: string;
    fDescription: string;
    fCompress: boolean;
    fApplyGraphics: boolean;
    fQuality: integer;
    fTagetKB: Int64;
    fShrinkByWidth: boolean;
    fShrinkByValue: integer;
    fRecordModified: boolean;
    fResampleMode: TResampleMode;
    fRotateAmount: TRotateAmount;
  private
    procedure SetCompress(const Value: boolean);
    procedure SetQuality(const Value: integer);
    procedure SetApplyGraphics(const Value: boolean);
    procedure SetShrinkByValue(const Value: integer);
    procedure SetShrinkByWidth(const Value: boolean);
    procedure SetTagetKB(const Value: Int64);
    procedure SetResampleMode(const Value: TResampleMode);
    procedure SetRotateAmount(const Value: TRotateAmount);
    procedure SetRecordModified(const Value: boolean);
    procedure SetPreviewModified(const Value: boolean);
  public
    constructor Create;
    procedure Reset;
    property Filename: string read fFilename write fFilename;
    property PreviewCompression: boolean read fPreviewCompression write fPreviewCompression;
    property Stretch: boolean read fStretch write fStretch;
    property AddToJSON: boolean read fAddToJSON write fAddToJSON;
    property SourcePrefix: string read fSourcePrefix write fSourcePrefix;
    property Description: string read fDescription write fDescription;
    property Compress: boolean read fCompress write SetCompress;
    property Quality: integer read fQuality write SetQuality;
    property TagetKB: Int64 read fTagetKB write SetTagetKB;
    property ApplyGraphics: boolean read fApplyGraphics write SetApplyGraphics;
    property ShrinkByWidth: boolean read fShrinkByWidth write SetShrinkByWidth;
    property ShrinkByValue: integer read fShrinkByValue write SetShrinkByValue;
    property ResampleMode: TResampleMode read fResampleMode write SetResampleMode;
    property RotateAmount: TRotateAmount read fRotateAmount write SetRotateAmount;
    property RecordModified: boolean read fRecordModified write SetRecordModified;
    property PreviewModified: boolean read fPreviewModified write SetPreviewModified;
  end;

implementation

{ TImageConfig }

constructor TImageConfig.Create;
begin
  inherited;
  fResampleMode := rmRecommended;
  fRotateAmount := raNone;
  Reset;
end;

procedure TImageConfig.Reset;
begin
  fPreviewModified := false;
  fRecordModified := false;
  fAddToJSON := true;
  fSourcePrefix := 'images/';
  fDescription := '';
  fCompress := true;
  fApplyGraphics := false;
  fPreviewCompression := false;
  fStretch := false;
  fQuality := cDefaultQuality;
  fTagetKB := 0;
  fShrinkByWidth := true;
  fShrinkByValue := cDefaultMaxWidth;
end;

procedure TImageConfig.SetCompress(const Value: boolean);
begin
  RecordModified := fRecordModified or (fCompress <> Value);
  fCompress := Value;
end;

procedure TImageConfig.SetPreviewModified(const Value: boolean);
begin
  fPreviewModified := Value;
end;

procedure TImageConfig.SetQuality(const Value: integer);
begin
  RecordModified := fRecordModified or (fQuality <> Value);
  fQuality := Value;
end;

procedure TImageConfig.SetRecordModified(const Value: boolean);
begin
  fRecordModified := Value;
  if fRecordModified then
    fPreviewModified := true;
end;

procedure TImageConfig.SetResampleMode(const Value: TResampleMode);
begin
  RecordModified := fRecordModified or (fResampleMode <> Value);
  fResampleMode := Value;
end;

procedure TImageConfig.SetRotateAmount(const Value: TRotateAmount);
begin
  RecordModified := fRecordModified or (fRotateAmount <> Value);
  fRotateAmount := Value;
end;

procedure TImageConfig.SetApplyGraphics(const Value: boolean);
begin
  RecordModified := fRecordModified or (fApplyGraphics <> Value);
  fApplyGraphics := Value;
end;

procedure TImageConfig.SetShrinkByValue(const Value: integer);
begin
  RecordModified := fRecordModified or (fShrinkByValue <> Value);
  fShrinkByValue := Value;
end;

procedure TImageConfig.SetShrinkByWidth(const Value: boolean);
begin
  RecordModified := fRecordModified or (fShrinkByWidth <> Value);
  fShrinkByWidth := Value;
end;

procedure TImageConfig.SetTagetKB(const Value: Int64);
begin
  RecordModified := fRecordModified or (fTagetKB <> Value);
  fTagetKB := Value;
end;



end.
