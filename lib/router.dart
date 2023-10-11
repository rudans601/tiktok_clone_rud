import 'package:go_router/go_router.dart';

import 'features/videos/video_recoding_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const VideoRecodingScreen(),
    ),
  ],
);
