import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({ImagePicker imagePicker, ImageCropper imageCropper})
      : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<List<XFile>> pickImage(
      {ImageSource source = ImageSource.gallery,
      int imagequality = 100,
      bool multi = false}) async {
    if (multi) {
      return await _imagePicker.pickMultiImage(imageQuality: imagequality);
    }
    final file = await _imagePicker.pickImage(
        source: source, imageQuality: imagequality);

    if (file != null) return [file];
    return [];
  }

  Future<CroppedFile> crop(
          {XFile file, CropStyle cropStyle = CropStyle.rectangle}) async =>
      await _imageCropper.cropImage(
          cropStyle: cropStyle, sourcePath: file.path);
}
