import 'dart:convert';
import 'dart:io';

import 'package:dev_template/product/core/model/shoe.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// IJsonService
abstract class IJsonService {
  /// Get shoes
  Future<List<Shoe>> getShoes();

  /// Save shoes
  Future<void> saveShoes(List<Shoe> shoes);

  /// Load shoes from a selected JSON file
  Future<List<Shoe>> loadShoesFromFile();

  /// Export shoes to a selected file location
  Future<void> exportShoes(List<Shoe> shoes);
}

/// JsonService
class JsonService implements IJsonService {
  @override
  Future<List<Shoe>> getShoes() async {
    // JSON dosyasını assetlerden oku
    final response = await rootBundle.loadString('assets/shoes/shoes.json');
    // JSON verisini decode et
    final data = json.decode(response) as List<dynamic>;

    // JSON verisini Shoe modeline çevir
    final shoes =
        data.map((e) => Shoe.fromJson(e as Map<String, dynamic>)).toList();

    return shoes;
  }

  @override
  Future<void> saveShoes(List<Shoe> shoes) async {
    // JSON verisini encode et
    final jsonString = json.encode(shoes.map((e) => e.toJson()).toList());

    // Dosya yolunu al
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/shoes.json';

    // Dosyaya yaz
    final file = File(filePath);
    await file.writeAsString(jsonString);
  }

  @override
  Future<List<Shoe>> loadShoesFromFile() async {
    // File Picker ile dosya seç
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null) {
      // Dosya seçilmedi
      return [];
    }

    // Seçilen dosyanın yolunu al
    final file = File(result.files.single.path!);

    // JSON dosyasını oku
    final jsonString = await file.readAsString();

    // JSON verisini decode et
    final data = json.decode(jsonString) as List<dynamic>;

    // JSON verisini Shoe modeline çevir
    final shoes =
        data.map((e) => Shoe.fromJson(e as Map<String, dynamic>)).toList();

    return shoes;
  }

  @override
  Future<void> exportShoes(List<Shoe> shoes) async {
    try {
      final jsonString = json.encode(shoes.map((e) => e.toJson()).toList());

      // File Picker ile dosyanın kaydedileceği yeri seç
      final outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save JSON file',
        type: FileType.custom,
        allowedExtensions: ['json'],
        fileName: 'shoes.json',
      );

      if (outputFile == null) {
        // Dosya seçilmedi
        print('File save operation was canceled.');
        return;
      }

      final file = File(outputFile);
      await file.writeAsString(
        jsonString,
        flush: true,
      );

      print('File successfully written to $outputFile');
    } catch (e) {
      print('Error exporting shoes: $e');
    }
  }
}
