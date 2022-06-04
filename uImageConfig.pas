unit uImageConfig;

interface

uses
  uJPEGCompressor;

type
  TImageConfig = class(TObject)
  strict private
    fPreviewCompression: boolean;
    fStretch: boolean;
    fFilename: string;
    fAddToJSON: boolean;
    fSourcePrefix: string;
    fDescription: string;
    fCompress: boolean;
    fShrink: boolean;
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
    procedure SetShrink(const Value: boolean);
    procedure SetShrinkByValue(const Value: integer);
    procedure SetShrinkByWidth(const Value: boolean);
    procedure SetTagetKB(const Value: Int64);
    procedure SetResampleMode(const Value: TResampleMode);
    procedure SetRotateAmount(const Value: TRotateAmount);
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
    property Shrink: boolean read fShrink write SetShrink;
    property ShrinkByWidth: boolean read fShrinkByWidth write SetShrinkByWidth;
    property ShrinkByValue: integer read fShrinkByValue write SetShrinkByValue;
    property RecordModified: boolean read fRecordModified write fRecordModified;
    property ResampleMode: TResampleMode read fResampleMode write SetResampleMode;
    property RotateAmount: TRotateAmount read fRotateAmount write SetRotateAmount;
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
  fRecordModified := false;
  fAddToJSON := true;
  fSourcePrefix := 'images/';
  fDescription := '';
  fCompress := false;
  fShrink := false;
  fPreviewCompression := false;
  fStretch := false;
  fQuality := cDefaultQuality;
  fTagetKB := 0;
  fShrinkByWidth := true;
  fShrinkByValue := cDefaultMaxWidth;
end;

procedure TImageConfig.SetCompress(const Value: boolean);
begin
  fRecordModified := fRecordModified or (fCompress <> Value);
  fCompress := Value;
end;

procedure TImageConfig.SetQuality(const Value: integer);
begin
  fRecordModified := fRecordModified or (fQuality <> Value);
  fQuality := Value;
end;

procedure TImageConfig.SetResampleMode(const Value: TResampleMode);
begin
  fRecordModified := fRecordModified or (fResampleMode <> Value);
  fResampleMode := Value;
end;

procedure TImageConfig.SetRotateAmount(const Value: TRotateAmount);
begin
  fRecordModified := fRecordModified or (fRotateAmount <> Value);
  fRotateAmount := Value;
end;

procedure TImageConfig.SetShrink(const Value: boolean);
begin
  fRecordModified := fRecordModified or (fShrink <> Value);
  fShrink := Value;
end;

procedure TImageConfig.SetShrinkByValue(const Value: integer);
begin
  fRecordModified := fRecordModified or (fShrinkByValue <> Value);
  fShrinkByValue := Value;
end;

procedure TImageConfig.SetShrinkByWidth(const Value: boolean);
begin
  fRecordModified := fRecordModified or (fShrinkByWidth <> Value);
  fShrinkByWidth := Value;
end;

procedure TImageConfig.SetTagetKB(const Value: Int64);
begin
  fRecordModified := fRecordModified or (fTagetKB <> Value);
  fTagetKB := Value;
end;



end.
