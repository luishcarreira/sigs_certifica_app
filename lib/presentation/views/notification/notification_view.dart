import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:sigs_certifica_app/locator.dart';
import 'package:sigs_certifica_app/presentation/viewmodel/notification/notification_view_model.dart';

class NotificationView extends StatefulWidget {
  const NotificationView(this.payload, {super.key});

  final String? payload;

  @override
  NotificationViewState createState() => NotificationViewState();
}

class NotificationViewState extends State<NotificationView> {
  late NotificationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    // Inicializa a ViewModel usando getIt
    viewModel = getIt<NotificationViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        bottom: _buildFilterBar(),
      ),
      body: Watch.builder(
        builder: (context) {
          return ListView.builder(
            itemCount: viewModel.messages.length,
            itemBuilder: (context, index) {
              final message = viewModel.messages.elementAt(index);

              return ListTile(
                title: Text(message.messageId ?? 'No Message ID'),
                subtitle: Text(message.sentTime?.toString() ?? 'No Time'),
                onTap: () {
                  debugPrint("Notificação clicada: ${message.messageId}");
                },
              );
            },
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildFilterBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: OverflowBar(
        spacing: 12,
        alignment: MainAxisAlignment.start,
        children: [
          TextButton(
            child: const Text('Todas'),
            onPressed: () {
              setState(() {
                // Lógica para mostrar todas as notificações
              });
            },
          ),
          TextButton(
            child: const Text('Arquivadas'),
            onPressed: () {
              //viewModel.clearArchivedNotifications(); // Limpa notificações
            },
          ),
        ],
      ),
    );
  }
}
