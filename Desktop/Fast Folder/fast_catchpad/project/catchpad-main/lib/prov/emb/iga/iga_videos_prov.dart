// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// class VideoControllerIGAControlNotifier extends StateNotifier<CustomVideoPlayerController?> {
//   VideoControllerIGAControlNotifier(CustomVideoPlayerController? state) : super(null);
//
//   late String videoUrl;
//
//   late CachedVideoPlayerController _videoPlayerController;
//
//   final CustomVideoPlayerSettings _customVideoPlayerSettings =
//        CustomVideoPlayerSettings(
//           customAspectRatio: 100.w / 100.h,
//           showSeekButtons: false,
//           allowVolumeOnSlide: false,
//           showDurationPlayed: false,
//           showDurationRemaining: false,
//           showFullscreenButton: false,
//           showMuteButton: false,
//           alwaysShowThumbnailOnVideoPaused: false,
//           showPlayButton: false,
//           enterFullscreenOnStart: false,
//       );
//
//
//   void setUrl(String url) => videoUrl = url;
//
//
//   Future<CustomVideoPlayerController?> initialize(WidgetRef ref, String url) async {
//     setUrl(url);
//
//     _videoPlayerController = CachedVideoPlayerController.asset("assets/iga/iga_movie.mp4",)
//       ..initialize().then((_) {
//         _videoPlayerController.setVolume(0);
//         _videoPlayerController.setLooping(true);
//         _videoPlayerController.play();
//
//       });
//
//     final cusViController = CustomVideoPlayerController(
//       context: ref.context,
//       videoPlayerController: _videoPlayerController,
//       customVideoPlayerSettings: _customVideoPlayerSettings,
//     );
//
//     changeState(cusViController);
//
//     await Future.delayed(const Duration(milliseconds: 20));
//
//     state!.videoPlayerController.play();
//
//     return state;
//   }
//
//
//
//   void changeState(CustomVideoPlayerController controller){
//     state = controller;
//   }
// }
