class CustomNotificationDTO {
  final int id;
  final String? title;
  final String? body;
  final String? payload;
  //final RemoteMessage? remoteMessage;

  CustomNotificationDTO({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    //this.remoteMessage,
  });
}
