import 'dart:io';
import 'package:path_provider/path_provider.dart';

///
/// Storage Handler for saving the index
///
class Storage {
  /// Get the local path to where we can save the file.
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  /// Get the local file.
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/index.txt');
  }

  /// Read in the index
  Future<int> readIndex() async {
    try {

      // Get the file
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      //Return the index
      return int.parse(contents);

    } catch (e) {
      // If encountering an error, return 0
      // To ways to error:
      // 1. A Actual error
      // 2. The file does not exist.
      return 0;
    }
  }

  /// Write in the new index
  Future<File> writeIndex(int index) async {
    //Get the file
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$index');
  }
}