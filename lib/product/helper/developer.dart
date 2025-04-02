class Developer {
  static final bool _developmentrMode = true;

  // Blue text
  static void logInfo(Object msg) {
    if (_developmentrMode) {
      print('\x1B[34m${msg.toString()}\x1B[0m');
    }
  }

// Green text
  static void logSuccess(Object msg) {
    if (_developmentrMode) {
      print('\x1B[32m${msg.toString()}\x1B[0m');
    }
  }

// Yellow text
  static void logWarning(Object msg) {
    if (_developmentrMode) {
      print('\x1B[33m${msg.toString()}\x1B[0m');
    }
  }

// Red text
  static void logError(Object msg) {
    if (_developmentrMode) {
      print('\x1B[31m${msg.toString()}\x1B[0m');
    }
  }

  static void logInfoRepository(Object msg) {
    if (true) {
      print('\x1B[35m${msg.toString()}\x1B[0m');
    }
  }
}
