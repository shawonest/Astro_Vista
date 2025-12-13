import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/astronomy_picture.dart';
import '../bloc/apod_bloc.dart';
import '../bloc/apod_event.dart';
import '../bloc/apod_state.dart';
import '../../../../injection_container.dart'; // To access 'sl'

class ApodScreen extends StatelessWidget {
  const ApodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApodBloc>(
      create: (context) => sl<ApodBloc>()..add(const GetApod()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Astronomy Picture of the Day'),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ApodBloc, ApodState>(
      builder: (context, state) {
        if (state is ApodLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ApodError) {
          return Center(child: Text("Error: ${state.error?.message}"));
        }
        if (state is ApodLoaded) {
          return _buildApodView(state.apod!);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildApodView(AstronomyPicture apod) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          if (apod.url != null)
            CachedNetworkImage(
              imageUrl: apod.url!,
              placeholder: (context, url) =>
              const SizedBox(height: 250, child: Center(child: CircularProgressIndicator())),
              errorWidget: (context, url, error) =>
              const SizedBox(height: 250, child: Center(child: Icon(Icons.error))),
              fit: BoxFit.cover,
              width: double.infinity,
            ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  apod.title ?? "No Title",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Date & Copyright
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      apod.date ?? "",
                      style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
                    ),
                    if (apod.copyright != null)
                      Text(
                        "© ${apod.copyright!.replaceAll('\n', '')}",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Explanation
                Text(
                  apod.explanation ?? "",
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}