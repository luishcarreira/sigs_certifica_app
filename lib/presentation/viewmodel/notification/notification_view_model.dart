import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:signals/signals.dart';

class NotificationViewModel {
  final messages =
      listSignal<RemoteMessage>([]); // Lista reativa para mensagens

  NotificationViewModel() {
    _listenToNotifications();
  }

  // Escuta mensagens recebidas em tempo real
  void _listenToNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      messages.value = [...messages.value, message]; // Adiciona nova mensagem
    });
  }

  // Recuperar todas as notificações recebidas
  List<RemoteMessage> getAllNotifications() {
    return messages.value;
  }
}
