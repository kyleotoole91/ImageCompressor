# Turbo Image Compressor

![TurboImage](https://user-images.githubusercontent.com/49255786/177213327-0aac0054-cb46-40b1-969f-6ee56f266a44.JPG)

This project was written in Delphi (Object Pascal), built using RAD Studio 10.4. 
It makes use of the Image32 graphics library and the superobject JSON writer/parser.
InnoSetup was used for the installation wizard.

This was created to quickly and easily compress images for websites or email attachments.

The application lets you scan a directory for images, apply compression, resizing, resampling and rotation to images.

You can change compression settings independantly for each image and execute the compression in a batch of selected images.
You can select which images you wish to include, indicated by the ticked state of the checkboxes in the images list.

You can activate Preview Compression to see the image quality change in realtime as you adjust the compression settings.

For compression, you may state a target kilobytes, when set to a value higher than 0, it will keep compressing the image incementally reducing quality until it reaches as close to the target value as possible. You may need to reduce the size of the image aswell in order to get to your taget (250KB is ideal for websites).

In the graphics settings group, you can reduce the height and width of an image by specifying a max width or max height, this will maintain the aspect ratio.
Here you can chose your desired resamping method for improved image quality. 
You can also rotate the image 90, 180 or 270 degrees.

You have an option to include a json file in the output directory, you may import this file into a NoSQL document database such as MongoDB. It includes all the images compressed, you may set the description and prefix independantly for each image.

In View options, Apply Best Fit will increase image preview quality by apply a scale to the JPEG to prevent the TImage from squashing it down to fit which results in pixellation. If DevExpress is installed, a TdxSmartImage graphic may be applied to the TImage, this results in better image preview quality at all sizes, removing the need for Apply Best Fit.

Currently only supports .JPG image files.

Product info and support page: https://eireware.com

Published on Softpedia: https://www.softpedia.com/get/Multimedia/Graphic/Digital-Photo-Tools/Turbo-Image-Compressor.shtml

Please ignore the Windows Smart Screen warning, the file is not dangerous, it simply hasn't been signed yet or downloaded enough times.

# Turbo Image Compressor CLI

A command-line interface for compressing JPEG images to target file sizes while maintaining the best possible quality. The tool can also generate thumbnails and preserves the original directory structure in the output.

## Features

- Compress JPEG images to a target file size in kilobytes
- Generate thumbnails with customizable dimensions
- Preserve directory structure when processing folders
- Process multiple images in batch
- Detailed console output with compression statistics

## Usage

```
TurboImageCompressorCLI.exe <input> <output_dir> <target_kb> [options]
```

### Parameters

- `input`: Path to a single JPEG file or a directory containing JPEG images
- `output_dir`: Directory where compressed images will be saved
- `target_kb`: Target file size in kilobytes (0 for quality-based compression)

### Options

- `-t`: Create thumbnails for each processed image
- `-s <size>`: Set thumbnail size in pixels (default: 150)

### Examples

Process a single image, targeting 500KB file size:
```
TurboImageCompressorCLI.exe C:\Photos\image.jpg C:\Output 500
```

Process all images in a directory, targeting 500KB file size:
```
TurboImageCompressorCLI.exe C:\Photos C:\Output 500
```

Process a single image and create thumbnail:
```
TurboImageCompressorCLI.exe C:\Photos\image.jpg C:\Output 500 -t
```

Process images with custom thumbnail size:
```
TurboImageCompressorCLI.exe C:\Photos C:\Output 500 -t -s 200
```

## Output

For each processed image, the tool will display:
- Original file path
- Output file path
- Thumbnail path (if enabled)
- Original file size in KB
- Compressed file size in KB

The compressed images will be saved in the output directory, maintaining the same folder structure as the input directory.

## Requirements

- Windows operating system
- Delphi runtime

## Building from Source

To build the project, you need:
1. Delphi IDE
2. The following dependencies:
   - SuperObject library
   - Image32 library

## Notes

- The tool processes all JPEG files recursively in the input directory
- Files with extensions `.jpg` and `.jpeg` are supported
- The original files are never modified
- Output directory structure mirrors the input directory structure

# License

Distributed under the MIT License. See LICENSE.txt for more information.
