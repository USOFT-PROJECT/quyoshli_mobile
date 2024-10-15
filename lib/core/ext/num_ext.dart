import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quyoshli/core/ext/string_ext.dart';

extension NumExt on num {
  String get decimal => NumberFormat.decimalPattern(Get.locale?.languageCode)
      .format(this)
      .replaceAll(',', String.fromCharCode(160))
      .nonBreaking();
}
