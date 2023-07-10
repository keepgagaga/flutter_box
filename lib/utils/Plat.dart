import 'dart:io';

class Plat {
  bool isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  bool isDesktop() {
    return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  }
}
