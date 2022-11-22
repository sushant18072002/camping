

// Blue text
void logInfo(String msg) {
 print('\x1B[34m$msg\x1B[0m');
}

// Green text
void logSuccess(String msg) {
 print('\x1B[32m$msg\x1B[0m');
}

// Yellow text
void logWarning(String msg) {
 print('\x1B[33m$msg\x1B[0m');
}

// Red text
void logError(String msg) {
 print('\x1B[31m$msg\x1B[0m');
}
