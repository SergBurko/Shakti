import 'package:flutter/widgets.dart';
import 'package:shakti/common/enums/login_state_enum.dart';

class LoginScreenSettings {
  LoginStatesEnum loginState = LoginStatesEnum.login;
  Map<String,String> keyData = {};

  LoginScreenSettings();

  changeLoginState () {
    loginState =  loginState == LoginStatesEnum.login ? LoginStatesEnum.registration : LoginStatesEnum.login ;
  }
}

/* 
  // Создаем экземпляр Key и IV (Initialization Vector) для шифрования
  final key = Key.fromLength(32);
  final iv = IV.fromLength(16);

  // Создаем экземпляр Encrypter с выбранным алгоритмом шифрования
  final encrypter = Encrypter(AES(key));

  // Шифруем данные
  final plainText = 'Секретная информация';
  final encrypted = encrypter.encrypt(plainText, iv: iv);

  print('Зашифрованные данные: ${encrypted.base64}');

  // Расшифровываем данные
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print('Расшифрованные данные: $decrypted'); */