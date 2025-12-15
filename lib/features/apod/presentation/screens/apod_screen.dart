import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/astronomy_picture.dart';
import '../bloc/apod_bloc.dart';
import '../bloc/apod_event.dart';
import '../bloc/apod_state.dart';
import '../../../../injection_container.dart';
import '../widgets/apod_video_player.dart';

// 1. Changed to StatefulWidget to handle the "Love" toggle state
class ApodScreen extends StatefulWidget {
  const ApodScreen({super.key});

  @override
  State<ApodScreen> createState() => _ApodScreenState();
}

class _ApodScreenState extends State<ApodScreen> {
  // Local state to track if the item is liked
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Define colors
    final Color bgDark = const Color(0xFF0B0F19);
    final Color primaryGlow = const Color(0xFF9D00FF);
    final Color secondaryGlow = const Color(0xFF3D5AFE);
    final Color cardBg = const Color(0xFF1A1F2E).withOpacity(0.8);

    return BlocProvider<ApodBloc>(
      create: (context) => sl<ApodBloc>()..add(const GetApod()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: bgDark,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: _buildBody(primaryGlow, secondaryGlow, cardBg),
      ),
    );
  }

  Widget _buildBody(Color primaryGlow, Color secondaryGlow, Color cardBg) {
    return BlocBuilder<ApodBloc, ApodState>(
      builder: (context, state) {
        if (state is ApodLoading) {
          return Center(child: CircularProgressIndicator(color: primaryGlow));
        }
        if (state is ApodError) {
          return Center(
            child: Text(
              "Error: ${state.error?.message}",
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
        if (state is ApodLoaded) {
          return _buildApodView(
            context,
            state.apod!,
            primaryGlow,
            secondaryGlow,
            cardBg,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildApodView(
      BuildContext context,
      AstronomyPicture apod,
      Color primaryGlow,
      Color secondaryGlow,
      Color cardBg,
      ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =================================================
          // 1. MEDIA SECTION (Image OR Inline Video)
          // =================================================
          if (apod.mediaType == 'image' && apod.url != null)
          // CASE A: Standard Image
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.7, 1.0],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: CachedNetworkImage(
                imageUrl: apod.url!,
                placeholder: (context, url) => Container(
                  height: 350,
                  color: cardBg,
                  child: Center(
                      child: CircularProgressIndicator(color: primaryGlow)),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 350,
                  color: cardBg,
                  child: const Center(
                      child: Icon(Icons.error, color: Colors.red)),
                ),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
          else if (apod.url != null)
          // CASE B: Inline Youtube Player
          //
            ApodVideoPlayer(videoUrl: apod.url!)
          else
          // CASE C: Fallback (No URL)
            Container(height: 350, color: Colors.black),

          // =================================================
          // 2. CONTENT SECTION (Title, Date, Desc)
          // =================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // --- Title and Interactive Love Button ---
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        apod.title ?? "No Title",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // The Favorite Button Container
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        // Optional: Add logic here to save to database
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [primaryGlow, secondaryGlow],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isFavorite
                                  ? const Color(0xFFFF4081).withOpacity(0.6)
                                  : primaryGlow.withOpacity(0.5),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              key: ValueKey<bool>(isFavorite),
                              color: isFavorite
                                  ? const Color(0xFFFF4081)
                                  : Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Date
                Text(
                  apod.date ?? "",
                  style: TextStyle(
                    color: Colors.purple.shade200,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 30),

                // Explanation Container
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: primaryGlow.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryGlow.withOpacity(0.25),
                        blurRadius: 25,
                        spreadRadius: -5,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apod.explanation ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.white70,
                        ),
                      ),
                      if (apod.copyright != null) ...[
                        const SizedBox(height: 20),
                        Text(
                          "Image Credit & Copyright: ${apod.copyright!.replaceAll('\n', '')}",
                          style: TextStyle(
                            color: Colors.purple.shade300,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
