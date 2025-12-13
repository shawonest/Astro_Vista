import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/neo_entity.dart';
import '../bloc/neo_bloc.dart';
import '../bloc/neo_events.dart';
import '../bloc/neo_state.dart';

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
}