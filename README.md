# Turbo Image Compressor


![Compressor](https://user-images.githubusercontent.com/49255786/172027377-40bf8501-e70c-4c2c-82ab-fcf1b74d0ef1.JPG)

This project was written in Delphi (Object Pascal), built using RAD Studio 10.4. 
It makes use of the Image32 graphics library and the superobject JSON writer/parser.
InnoSetup was used for the installation wizard.

This was created to quickly and easily compress images for websites or email attachments.

The application lets you scan a directory for images, apply compression, resizing, resampling and rotation to images.

You can change compression settings independantly for each image and execute the compression for multiple or all images found. You can select which images you wish to include, indicated by the ticked state of the checkboxes in the images list.

You can activate Preview Compression to see the image quality change in realtime as you adjust the compression settings.

For compression, you may state a target kilobytes, when set to a value higher than 0, it will keep compressing the image incementally reducing quality until it reaches as close to the target value as possible. You may need to reduce the size of the image aswell in order to get to your taget (250KB is ideal for websites).

In the graphics settings group, you can reduce the height and width of an image by specifying a max width or max height, this will maintain the aspect ratio.
Here you can chose your desired resamping method for improved image quality. 
You can also rotate the image 90, 180 or 270 degrees.

You have an option to include a json file in the output directory, you may import this file into a NoSQL document database such as MongoDB. It includes all the images compressed, you may set the description and prefix independantly for each image.

In View options, Apply Best Fit will increase image preview quality by apply a scale to the JPEG to prevent the TImage from squashing it down to fit which results in pixellation. If DevExpress is installed, a TdxSmartImage graphic may be applied to the TImage, this results in better image preview quality at all sizes, removing the need for Apply Best Fit.

This currently only supports .JPG image files.

The installer can be downloaded from this link https://drive.google.com/file/d/1ipCqEGBb5ujVEBiBlNoWplAEHzDpniRW/view?usp=sharing
Ignore any warnings, it is not a virus.

# License

Distributed under the MIT License. See LICENSE.txt for more information.
