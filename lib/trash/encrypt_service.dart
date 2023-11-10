import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shakti/common/classes/dialogs.dart';
import 'package:shakti/common/classes/singleton.dart';
import 'package:uuid/uuid.dart';

class EncryptService {
  Map<String, String> encryptData = {
    'iv': '',
    'key': '',
  };
  final BuildContext context;

  EncryptService(this.context) {
    _readJsonFromFile().then((jsonData) {
      encryptData = jsonData;
    });
  }

  Future<Map<String, String>> _readJsonFromFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.json');

      // Проверяем существование файла
      if (await file.exists()) {
        final jsonData = await file.readAsString();
        encryptData = json.decode(jsonData);
        return encryptData;
      } else {
        encryptData["iv"] = const Uuid().v4();
        encryptData["key"] = const Uuid().v4();
        
        _writeJsonToFile(encryptData); //REKURSIVE METHOD

        if (!await file.exists()) {
          // ignore: use_build_context_synchronously
          // Dialogs.noAccesToDocumentDirectory(context);
        }
        return encryptData;
      }
    } catch (e) {
      throw FileSystemException(Singleton.fileNotFound);
    }
  }

  Future<void> _writeJsonToFile(Map<String, String> data,
      {int retries = 3}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.json');

      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      final jsonData = json.encode(data);

      await file.writeAsString(jsonData);
      print('JSON файл записан успешно.');
    } catch (e) {
      if (retries > 0) {
        await _writeJsonToFile(data, retries: retries - 1);
      } 
      // else {
      //   print('Too many attemts');
      // }
    }
  }
}
