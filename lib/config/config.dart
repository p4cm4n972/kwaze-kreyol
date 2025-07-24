const bool isProd = bool.fromEnvironment('dart.vm.product');
const String apiBaseUrl = isProd
    ? 'http://10.0.2.2:3000'
    : 'http://10.0.2.2:3000';
