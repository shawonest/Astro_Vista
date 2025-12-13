import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/solar_notification.dart';
import '../bloc/solar_bloc.dart';

/*
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
}*/



class SolarScreen extends StatelessWidget {
  const SolarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    final Color bgDark = const Color(0xFF0B0F19);

    return BlocProvider<SolarBloc>(
      create: (_) =>
      sl<SolarBloc>()
        ..add(GetSolarNotifications()),
      child: Scaffold(
        backgroundColor: bgDark,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Space Weather",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              shadows: [
                BoxShadow(
                  color: Colors.orangeAccent.withOpacity(0.6),
                  blurRadius: 15,
                )
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          // Optional subtle gradient background
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              radius: 1.5,
              colors: [
                const Color(0xFF1A1F2E),
                bgDark,
              ],
            ),
          ),
          child: BlocBuilder<SolarBloc, SolarState>(
            builder: (context, state) {
              if (state is SolarLoading) {
                return const Center(child: CircularProgressIndicator(
                    color: Colors.orangeAccent));
              }
              if (state is SolarError) {
                return Center(
                    child: Text("Error: ${state.error?.message}",
                        style: const TextStyle(color: Colors.white))
                );
              }
              if (state is SolarLoaded) {
                return ListView.separated(
                  // Add padding for transparent AppBar
                  padding: const EdgeInsets.fromLTRB(16, 100, 16, 20),
                  itemCount: state.notifications!.length,
                  separatorBuilder: (ctx, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _buildNeonNotificationCard(
                        context, state.notifications![index]);
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNeonNotificationCard(BuildContext context,
      SolarNotification note) {
    // 1. Determine Neon Color based on Type
    Color typeColor;
    IconData typeIcon;

    switch (note.messageType) {
      case 'FLR': // Flare (Hot/Sun)
        typeColor = const Color(0xFFFF9100);
        typeIcon = Icons.wb_sunny;
        break;
      case 'CME': // Coronal Mass Ejection (Danger/Red)
        typeColor = const Color(0xFFFF1744);
        typeIcon = Icons.error_outline;
        break;
      case 'GST': // Geomagnetic Storm (Magnetic/Purple)
        typeColor = const Color(0xFFD500F9);
        typeIcon = Icons.waves;
        break;
      case 'IPS': // Shock (Impact/Brown-Orange)
        typeColor = const Color(0xFFFF6D00);
        typeIcon = Icons.flash_on;
        break;
      default: // Other (Cool Blue)
        typeColor = const Color(0xFF00E5FF);
        typeIcon = Icons.info_outline;
    }

    final Color cardBg = const Color(0xFF1A1F2E).withOpacity(0.9);

    // 2. Custom Neon Card using Container & ExpansionTile
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: typeColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: typeColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        // Override ExpansionTile default colors to remove dividers and match theme
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          collapsedIconColor: Colors.grey,
          iconColor: typeColor,
          // Arrow color when expanded
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

          // --- Header ---
          leading: Container(
            height: 45, width: 45,
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: typeColor.withOpacity(0.4), width: 1),
            ),
            child: Icon(typeIcon, color: typeColor, size: 24),
          ),
          title: Text(
            note.messageID,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              note.messageIssueTime.split("T").join(" ").replaceAll("Z", ""),
              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            ),
          ),

          // --- Expanded Body ---
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey[800]),
                  const SizedBox(height: 10),
                  Text(
                    note.messageBody.replaceAll("##", ""),
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // View Report Button
                  if(note.messageURL.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                            foregroundColor: typeColor,
                            backgroundColor: typeColor.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8)
                        ),
                        icon: const Icon(Icons.open_in_new, size: 16),
                        label: const Text("View Full Report"),
                        onPressed: () {
                          // Implement URL Launcher
                        },
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

