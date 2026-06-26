/// Definition of private environment variables.
///
/// Copy 'env.dart' to '.env.dart' to define environment variables specific to
/// your machine only.
class Env {
  /// The host of the local Academity API server.
  static const academityHost = 'localhost:8080';

  /// The base url of the local Academity API server.
  static const academityUrl = 'http://$academityHost/';
}
