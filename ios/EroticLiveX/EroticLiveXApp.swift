import SwiftUI
import Firebase

@main
struct EroticLiveXApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Configurar Firebase
        FirebaseApp.configure()
        
        // Solicitar permiso para notificaciones push
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorizationWithOptions(
            [.alert, .sound, .badge],
            completionHandler: { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        )
        
        return true
    }
    
    // MARK: - Push Notifications
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Fallo al registrar notificaciones push: \(error.localizedDescription)")
    }
}

// MARK: - UNUserNotificationCenter Delegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    // Manejar notificaciones cuando la app está abierta
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        
        if let title = notification.request.content.title as? String {
            print("Notificación recibida: \(title)")
        }
        
        completionHandler([[.banner, .sound, .badge]])
    }
    
    // Manejar tap en notificaciones
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        
        // Procesar la notificación según sea necesario
        print("Usuario hizo tap en notificación")
        
        completionHandler()
    }
}

// MARK: - Messaging Delegate

extension AppDelegate: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        if let token = fcmToken {
            print("FCM Token: \(token)")
            // Guardar token en base de datos si es necesario
        }
    }
}
