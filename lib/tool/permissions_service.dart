import 'package:leggo/common/configs/permission.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future permissionGranted() async {
    bool granted = true;
    kPermissions.forEach((element) async {
      PermissionStatus s = await element.status;
      if (!s.isGranted) {
        granted = false;
      }
    });
    if (!granted) {
      reqAllPermission();
    }
  }

  static Future reqAllPermission() async {
    return await Future.forEach(kPermissions, (Permission element) async {
      return await element.request();
    });
  }

  static  Future reqPermission(Permission permission) async {
    return permission.request();
  }

  Future checkPermission(Permission permission) async {
    return permission.status;
  }
}