import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView(this.payload, {super.key});

  final String? payload;

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  String? _payload;
  List<RemoteMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _messages = [..._messages, message];
      });
    });
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        bottom: PreferredSize(
          preferredSize: preferredSize,
          child: OverflowBar(
            spacing: 12,
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(child: const Text('Todas'), onPressed: () {}),
              TextButton(child: const Text('Arquivadas'), onPressed: () {}),
            ],
          ),
        ),
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            RemoteMessage message = _messages[index];

            return ListTile(
              title: Text(
                  message.messageId ?? 'no RemoteMessage.messageId available'),
              subtitle: Text(
                  message.sentTime?.toString() ?? DateTime.now().toString()),
              onTap: () => {},
            );
          },
        ),
      ),
    );
  }
}
