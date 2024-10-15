import 'package:get/get.dart';
import 'package:quyoshli/core/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart';


extension StringExt on String {
  String nonBreaking() =>
      replaceAll(String.fromCharCode(160), AppConstants.narrowNonBreakingSpace);

  String get decimalStr => NumberFormat.decimalPattern(Get.locale?.languageCode)
      .format(num.tryParse(this))
      .replaceAll(',', String.fromCharCode(160))
      .nonBreaking();

  String get parseHtmlString {
    final document = parse(this);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    return parsedString;
  }
}
