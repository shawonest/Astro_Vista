import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/neo_entity.dart';
import '../bloc/neo_bloc.dart';
import '../bloc/neo_events.dart';
import '../bloc/neo_state.dart';

/*
class NeoListScreen extends StatelessWidget {
  const NeoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NeoBloc>(
      create: (_) => sl<NeoBloc>()..add(GetNeoList()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Near Earth Objects")),
        body: BlocBuilder<NeoBloc, NeoState>(
          builder: (context, state) {
            if (state is NeoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NeoError) {
              return Center(child: Text("Error: ${state.error?.message}"));
            }
            if (state is NeoLoaded) {
              return ListView.builder(
                itemCount: state.neos!.length,
                itemBuilder: (context, index) {
                  return _buildNeoItem(state.neos![index]);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildNeoItem(NeoEntity neo) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: neo.isHazardous ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
      child: ListTile(
        leading: Icon(
          Icons.public, // Representing a planet/asteroid
          color: neo.isHazardous ? Colors.red : Colors.green,
          size: 32,
        ),
        title: Text(neo.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Date: ${neo.closeApproachDate}"),
            Text("Diameter: ${double.parse(neo.diameterMaxKm).toStringAsFixed(2)} km"),
            Text("Distance: ${double.parse(neo.missDistanceKm).toStringAsFixed(0)} km"),
          ],
        ),
        trailing: neo.isHazardous
            ? const Icon(Icons.warning, color: Colors.red)
            : const Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }
}*/


class NeoListScreen extends StatelessWidget {
  const NeoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    final Color bgDark = const Color(0xFF0B0F19);
    final Color cardBg = const Color(0xFF1A1F2E).withOpacity(0.8);

    return BlocProvider<NeoBloc>(
      create: (_) => sl<NeoBloc>()..add(GetNeoList()),
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
            "Near Earth Objects",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              shadows: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.6),
                  blurRadius: 15,
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          // Optional: Add a subtle gradient background to the whole screen
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 1.5,
              colors: [
                const Color(0xFF1A1F2E), // Lighter dark at top
                bgDark, // Deep dark at bottom
              ],
            ),
          ),
          child: BlocBuilder<NeoBloc, NeoState>(
            builder: (context, state) {
              if (state is NeoLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.cyanAccent),
                );
              }
              if (state is NeoError) {
                return Center(
                  child: Text(
                    "Error: ${state.error?.message}",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }
              if (state is NeoLoaded) {
                return ListView.separated(
                  // Add padding to account for transparent AppBar
                  padding: const EdgeInsets.only(
                    top: 100,
                    bottom: 20,
                    left: 16,
                    right: 16,
                  ),
                  itemCount: state.neos!.length,
                  separatorBuilder: (ctx, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _buildNeoItem(context, state.neos![index], cardBg);
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

  Widget _buildNeoItem(BuildContext context, NeoEntity neo, Color cardBg) {
    // Determine Theme based on Hazard Status
    final bool isHazard = neo.isHazardous;
    final Color primaryColor = isHazard
        ? const Color(0xFFFF1744)
        : const Color(0xFF00E5FF); // Red vs Cyan
    final Color secondaryColor = isHazard
        ? const Color(0xFFFF9100)
        : const Color(0xFF00E676); // Orange vs Green
    final IconData mainIcon = isHazard
        ? Icons.warning_amber_rounded
        : Icons.public;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // --- Icon Box ---
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: Icon(mainIcon, color: primaryColor, size: 28),
            ),
            const SizedBox(width: 16),

            // --- Info Column ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    neo.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 12,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        neo.closeApproachDate,
                        style: TextStyle(color: Colors.grey[400], fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Stats (Diameter & Distance)
                  Row(
                    children: [
                      // Diameter
                      _buildStatBadge(
                        "${double.parse(neo.diameterMaxKm).toStringAsFixed(2)} km",
                        Icons.circle_outlined,
                        Colors.purple.shade200,
                      ),
                      const SizedBox(width: 8),
                      // Distance
                      _buildStatBadge(
                        "${double.parse(neo.missDistanceKm).toStringAsFixed(0)} km",
                        Icons.space_bar, // Or linear_scale
                        Colors.blue.shade200,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Trailing Status Icon ---
            if (isHazard)
              Icon(
                Icons.error_outline,
                color: primaryColor.withOpacity(0.8),
                size: 24,
              )
            else
              Icon(
                Icons.check_circle_outline,
                color: secondaryColor.withOpacity(0.8),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  // Helper for small stat badges (Diameter/Distance)
  Widget _buildStatBadge(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

