import UIKit
import Flutter
import Firebase
import GoogleMaps
import PushKit                     /* <------ add this line */
import flutter_voip_push_notification

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//    FirebaseApp.configure()
    FirebaseApp.configure();
//    if (@available(iOS 10.0, *)) {
//      [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>) self;
//    }
    
    // Setup Notifications

//   if ([UNUserNotificationCenter class] != nil) {
//     // iOS 10 or later
//     // For iOS 10 display notification (sent via APNS)
//     [UNUserNotificationCenter currentNotificationCenter].delegate = self;
//     UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
//     UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
//     [FIRMessaging messaging].delegate = self;
//     [[UNUserNotificationCenter currentNotificationCenter]
//      requestAuthorizationWithOptions:authOptions
//      completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (error) { NSLog(@"%@", error); }
//      }];
//   } else {
//     // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
//     UIUserNotificationType allNotificationTypes =
//     (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
//     UIUserNotificationSettings *settings =
//     [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
//     [application registerUserNotificationSettings:settings];
//   }
    
    if #available(iOS 10.0, *) {
      // For iOS 10 display notification (sent via APNS)
      UNUserNotificationCenter.current().delegate = self

      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: {_, _ in })
    } else {
      let settings: UIUserNotificationSettings =
      UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
    
    application.registerForRemoteNotifications();
    

    GMSServices.provideAPIKey("AIzaSyBgj9olJajssax5PritKjU4oy0li4UYJ5I")
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func pushRegistry(_ registry: PKPushRegistry,
                      didReceiveIncomingPushWith payload: PKPushPayload,
                      for type: PKPushType,
                      completion: @escaping () -> Void){
        // Register VoIP push token (a property of PKPushCredentials) with server
        FlutterVoipPushNotificationPlugin.didReceiveIncomingPush(with: payload, forType: type.rawValue)
    }

    // Handle incoming pushes
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        // Process the received push
        FlutterVoipPushNotificationPlugin.didUpdate(pushCredentials, forType: type.rawValue);
    }
 }

