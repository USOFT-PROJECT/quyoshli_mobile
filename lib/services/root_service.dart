
import 'db_service.dart';

class RootService {
  static Future<void> init() async {
    await DBService.init(); // GetStorage Database
  }
}