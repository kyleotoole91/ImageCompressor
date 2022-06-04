# ImageCompressor


![Compressor](https://user-images.githubusercontent.com/49255786/172027377-40bf8501-e70c-4c2c-82ab-fcf1b74d0ef1.JPG)

This project was written in Delphi (Object Pascal), built using RAD Studio 10.4. 
It makes use of the Image32 graphics library and the superobject JSON writer/parser.

This application lets you scan a directory for images, apply compression, resizing, resampling and rotation to images.

You can change compression settings independantly for each image and execute the compression multiple or all images found at once.

You can activate Preview Compression to see the image quality change in realtime as you adjust the compression settings.

You have an option to include a json file in the output directory, you may import this file into a NoSQL document database such as MongoDB.

In View options, Apply Best Fit will increase image preview quality by apply a scale to the JPEG to prevent the TImage from squashing it down to fit which results in pixellation. If DevExpress is installed, a TdxSmartImage graphic may be applied to the TImage, this results in better image preview quality at all sizes, removing the need for Apply Best Fit.

This currently only supports .JPG image files.

# License

Distributed under the MIT License. See LICENSE.txt for more information.
