/// Definition of private environment variables.
///
/// Copy 'env.dart' to '.env.dart' to define environment variables specific to
/// your machine only.
class Env {
  /// The host of the Academity server.
  static const academityHost = '192.168.100.15:8080';

  /// The base url of the Academity server.
  static const academityUrl = 'http://$academityHost/';
}
