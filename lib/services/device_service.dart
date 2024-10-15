import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  static Future<String> androidVersion() async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.version.release;
  }

  static Future<String> iosVersion() async {
    var deviceInfo = DeviceInfoPlugin();
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.systemVersion;
  }

  static Future<String> deviceUniqueId() async {
    var deviceInfo = DeviceInfoPlugin();
    var deviceId = "";
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor ?? '';
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
    }
    return deviceId;
  }

  const DeviceService._();
}
