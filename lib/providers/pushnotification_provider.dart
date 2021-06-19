import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//mi cel
//dsGxMyXSG-o:APA91bEScTyNauI_JQHjmYAyVFgMV19ifblDl5FPUyWkKJuJt-tpWHz8M1wHHBmf-R2v6DhprwcDu04iBautzEeUmKb0pLHGDmrThdnP9K3jHZT2UGmFlHtO8BoG2tfDHoH_csSM7Pmn
//emulador
//cja-cxm_gHE:APA91bGeWG-Y4zVqHNw38VXmKw2ZC7FilnicMTzR9783UIDibFStI512teXEM0CmzDlU-uFFvvxF2hmGRKUvlNIDJwucHVe8glkQF8X5_ZCyHYyOGlwdoReSdhyy4CAcKwDbuibb4dB7
  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      //cuando esta abierta
      onMessage: (info) async {
        await showLocalNotification(info["notification"]["title"], info["notification"]["body"]);
      },
      //onLaunch cuando esta finalizada

      //onResume segundo plano
    );
  }

  Future showLocalNotification(String title, String body) async {
    FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();
    var androidInitialize = AndroidInitializationSettings("ic_launcher");
    var initializationSettings = new InitializationSettings(android: androidInitialize);
    localNotification.initialize(initializationSettings);
    var androidDetails = new AndroidNotificationDetails(
      "channelId",
      "Local Notificacion",
      "Description",
      importance: Importance.high,
    );
    var generalNotificationDetails = new NotificationDetails(android: androidDetails);
    await localNotification.show(
      0,
      title,
      body,
      generalNotificationDetails,
    );
  }
}
