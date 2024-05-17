import UIKit
import Flutter
import AppTrackingTransparency
import AdSupport

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Request user authorization for app tracking after the app launches
    requestTrackingAuthorization()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func requestTrackingAuthorization() {
    if #available(iOS 14, *) {
      ATTrackingManager.requestTrackingAuthorization { status in
        switch status {
        case .authorized:
            // Tracking authorization granted by the user
            print("Authorized for tracking")
        case .denied:
            // Tracking authorization denied by the user
            print("Denied tracking")
        case .notDetermined:
            // Tracking authorization has not yet been asked for
            print("Tracking authorization not determined")
        case .restricted:
            // Tracking authorization is restricted
            print("Tracking authorization restricted")
        @unknown default:
            // Handle other cases
            print("Unknown tracking authorization status")
        }
      }
    }
  }
}
