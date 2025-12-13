import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/solar_notification.dart';
import '../bloc/solar_bloc.dart';

class SolarScreen extends StatelessWidget {
  const SolarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SolarBloc>(
      create: (_) => sl<SolarBloc>()..add(GetSolarNotifications()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Space Weather")),
        body: BlocBuilder<SolarBloc, SolarState>(
          builder: (context, state) {
            if (state is SolarLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SolarError) {
              return Center(child: Text("Error: ${state.error?.message}"));
            }
            if (state is SolarLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.notifications!.length,
                itemBuilder: (context, index) {
                  return _buildNotificationCard(context, state.notifications![index]);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, SolarNotification note) {
    // Helper to color code the message types
    Color typeColor;
    switch (note.messageType) {
      case 'FLR': typeColor = Colors.orange; break; // Flare
      case 'CME': typeColor = Colors.redAccent; break; // Coronal Mass Ejection
      case 'GST': typeColor = Colors.purpleAccent; break; // Geomagnetic Storm
      case 'IPS': typeColor = Colors.brown; break; // Interplanetary Shock
      default: typeColor = Colors.blueGrey;
    }

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: typeColor.withOpacity(0.2),
          child: Text(
            note.messageType,
            style: TextStyle(color: typeColor, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        title: Text(
          note.messageID,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          note.messageIssueTime.split("T").join(" ").replaceAll("Z", ""),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                // Clean up the body text slightly for display
                Text(
                  note.messageBody.replaceAll("##", ""),
                  style: const TextStyle(height: 1.4),
                ),
                const SizedBox(height: 10),
                if(note.messageURL.isNotEmpty)
                  TextButton.icon(
                    icon: const Icon(Icons.link),
                    label: const Text("View Full Report"),
                    onPressed: () {
                      // Implement URL Launcher here later
                    },
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}