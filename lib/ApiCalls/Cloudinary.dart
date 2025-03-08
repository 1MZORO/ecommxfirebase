import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

class Cloudinary{
  final Dio _dio = Dio();
  final String cloudName = 'zoro1'; // Replace with your Cloudinary Cloud Name
  final String uploadPreset = 'products';

  Future<List<String>> uploadImages(List<File> imageFiles) async {
    List<String> uploadedUrls = [];

    try {
      log(imageFiles.toString());
      for (var imageFile in imageFiles) {
        String url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(imageFile.path),
          "upload_preset": uploadPreset, // Required for unsigned uploads
        });

        Response response = await _dio.post(url, data: formData);

        if (response.statusCode == 200) {
          String imageUrl = response.data["secure_url"];
          print("Image Uploaded: $imageUrl");
          uploadedUrls.add(imageUrl); // Add URL to list
        } else {
          print("Failed to upload: ${response.statusMessage}");
        }
      }
      log(uploadedUrls.toString());
      return uploadedUrls; // Return list of uploaded image URLs
    } catch (e) {
      print("Upload error: $e");
      return [];
    }
  }
}