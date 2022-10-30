import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationTimer extends StatelessWidget {
  final List items;
  NotificationTimer({super.key, required this.items});
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 60);
  final List dummyListCount = [];
  int? count;
  @override
  Widget build(BuildContext context) {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    for (var itemName in items) {
      var entryList = itemName.entries.toList();
      dummyListCount.add(entryList[2].value);
    }

    count = (int.tryParse(dummyListCount.first));
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown(count));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Plugin example app'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _showNotificationWithSound(items);
                },
                child:
                    const Text('See the notification & item quantity randomly'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onSelectNotification(String? payload) async {}

  Future _showNotificationWithSound(List item) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics =
        const IOSNotificationDetails(sound: "slow_spring_board.aiff");
    final List dummyListData = [];
    final List dummyListCount = [];
    for (var itemName in item) {
      var entryList = itemName.entries.toList();
      dummyListData.add(entryList[0].value);
      dummyListCount.add(entryList[2].value);
    }

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, dummyListData.first,
        setCountDown(count).toString(), platformChannelSpecifics);
  }

  int? setCountDown(int? item) {
    const reduceSecondsBy = 1;
    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else if (seconds == -1) {
    } else {
      myDuration = Duration(seconds: seconds);
    }
    count = count! - 1;
    return count;
  }
}
