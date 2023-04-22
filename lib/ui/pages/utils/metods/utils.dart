
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_ipify/dart_ipify.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as crypt;
import 'package:uuid/uuid.dart';


  class Utils {


  static String URL_WEB_SERVICE = "http://192.168.0.6:5001/api/";

  //String URL_WEB_SERVICE = "http://avaliacoes-backend.herokuapp.com/";
  static const String IMG_KEY = 'IMAGE_KEY';

  static String imprimeCPF(String cpf){
    return CPFValidator.format(cpf);
  }
  static bool validarCPF(String cpf){
    return CPFValidator.isValid(cpf);
  }

  static List listaDimensoes(){
    return   [
      {"id": 0, "dimensao":"Família"},
      {"id": 1, "dimensao": "Saúde"},
      {"id": 2, "dimensao": "Escola"},
      {"id": 3, "dimensao": "Professores"},
      {"id": 4, "dimensao": "Estudos"},
      {"id": 5, "dimensao": "Colegas"}
    ];
  }
  static List listaUrlEmojis(){
    return [
      'assets/images/Triste.png',
      'assets/images/Chateado.png',
      'assets/images/Normal.png',
      'assets/images/Feliz.png',
      'assets/images/Muito_Feliz.png'
    ];

  }
  static saveSession(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }
  static readSession(String? key) async {
    var prefs = await SharedPreferences.getInstance();
    var chave = prefs.getString(key!);
    return json.decode(chave!);
  }
  static removeSession(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static bool invalidEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return true;
    } else{
      return false;
    }
    }
  static  final key = crypt.Key.fromUtf8('put32charactershereeeeeeeeeeeee!'); //32 chars
  static final iv = crypt.IV.fromUtf8('put16characters!'); //16 chars

//encrypt
    static String encryptAES(String text) {
      final e = crypt.Encrypter(crypt.AES(key, mode: crypt.AESMode.cbc));
      final encrypted_data = e.encrypt(text, iv: iv);
      return encrypted_data.base64;
    }

//dycrypt
    static String decryptAES(String text) {
      final e = crypt.Encrypter(crypt.AES(key, mode: crypt.AESMode.cbc));
      final decrypted_data = e.decrypt(crypt.Encrypted.fromBase64(text), iv: iv);
      return decrypted_data;
    }
    //SHA1
    static String toSha1(String byte){

      var bytes = utf8.encode(byte); // data being hashed

      var value = sha1.convert(bytes);

      return value.toString();

    }
   static Future<bool> isConnected() async {

    bool flag = false;
      try {
        final result = await InternetAddress.lookup('globo.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          flag = true;
          print('connected');
        }
        } on SocketException catch (_) {

        print('not connected');
        flag = false;
        }
        return flag;
    }
    //Get my IP:
    static Future<String> getIpDevice() async{
      if(await isConnected()){
        final ipv4 = await Ipify.ipv4();
        return ipv4;
      }else{
        return "";
      }
    }
    /***************DataHora***************/

  static DateTime getDataHora(){
  return DateTime.now();
  }
  static String getDataHoraDotNet(){
    var now = DateTime.now();
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    return dateFormatted;
  }
  static DateTime? stringToDate(String dataHora){
    return DateTime.tryParse(dataHora);
  }
  static String formatarData(String data, bool small){
    var formater;

    initializeDateFormatting("pt_BR");
    if(small){
      formater = DateFormat("dd/MM/y");
    }else{
      formater = DateFormat("dd/MM/y H:m");
    }
    DateTime dataConvertida =  DateTime.parse(data);
    String date = formater.format(dataConvertida);

    return date;
  }
  /**************Mostrar Texto**************/
  static void showDefaultSnackbar(BuildContext context, String texto){
  //Scaffold.of(context).showSnackBar(
    final snackBar = SnackBar(
      content: Text((texto.isEmpty) ? "" : texto.toString()),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
  );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

    static Future<Position> getGeolocalizacao() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    }

  static String generateGuide(){
    var uuid = const Uuid();
    return uuid.v4();
  }
  static String showDose(String value){

      String dose = "";

      switch(value) {
        case 'D1':
        dose =  '1ª Dose';
        break;
        case 'D2':
         dose =  '2ª Dose';
        break;
        case 'D3':
         dose =  '3ª Dose';
        break;
        case 'D4':
          dose =  '4ª Dose';
        break;
        case 'REF':
          dose =  'Reforço';
        break;
        case 'UNI':
          dose =  'Única';
        break;

      }
      return dose;
  }

  static Future<bool> saveImageToPreferences(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(IMG_KEY, value);
  }

  static Future<String?> getImagesFromPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(IMG_KEY);
  }

  static String base64String(Uint8List bytes){
    return base64Encode(bytes);
  }

  static String formatarDateTime(DateTime? data){
      if(data != null ){
        if(data.month < 10 && data.day < 10){
          return '0${data.day}/0${data.month}/${data.year}';
        }else if(data.day >= 10 && data.month < 10){
          return '${data.day}/0${data.month}/${data.year}';
        }else if(data.day < 10 && data.month >= 10){
          return '0${data.day}/${data.month}/${data.year}';
        }else{
          return '${data.day}/${data.month}/${data.year}';
        }
      }
      return data.toString();

  }

  static Image imageFromBase64String(String bytes){
    return Image.memory(

        base64Decode(bytes),
        height: 80.0,
        width: 80.0,
        fit: BoxFit.fill,
        alignment: Alignment.center,

        );
  }
    static Uint8List fileFromBase64String(String bytes)=> base64.decode(bytes);

  }














































