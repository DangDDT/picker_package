// import 'dart:developer';

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:phan_anh_module/utils/const/enum.dart';
// import 'package:phan_anh_module/utils/const/styles.dart';
// import 'package:video_player/video_player.dart';
// import 'package:vif_flutter_base/vif_flutter_base.dart';

// class MyVideoPlayer extends StatefulWidget {
//   final String url;
//   const MyVideoPlayer({
//     super.key,
//     required this.url,
//   });

//   @override
//   State<MyVideoPlayer> createState() => _MyVideoPlayerState();
// }

// class _MyVideoPlayerState extends State<MyVideoPlayer> {
//   LoadingState _state = LoadingState.initial;
//   late String _videoUrl;
//   late final VideoPlayerController _controller;

//   _setLoadingState(LoadingState state) {
//     setState(() {
//       _state = state;
//     });
//   }

//   ChewieController? _chewieController;
//   @override
//   void initState() {
//     super.initState();
//     _videoUrl = widget.url;
//     initializeVideo();
//   }

//   Future<void> initializeVideo() async {
//     _setLoadingState(LoadingState.loading);
//     try {
//       _controller = VideoPlayerController.network(_videoUrl);
//       await _controller.initialize();
//       _chewieController = ChewieController(
//         videoPlayerController: _controller,
//         looping: true,
//       );
//       _setLoadingState(LoadingState.success);
//     } catch (e) {
//       log(e.toString(), name: "LOAD_VIDEO_FAILED");
//       _setLoadingState(LoadingState.failed);
//     }
//   }

//   @override
//   void dispose() {
//     if (_chewieController != null) {
//       _chewieController!.dispose();
//     }
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       if (_state == LoadingState.loading || _state == LoadingState.initial) {
//         return VIFBase.I.baseWidgets.loadingComponent();
//       } else if (_state == LoadingState.failed || _chewieController == null) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error,
//               color: Theme.of(context).colorScheme.error,
//             ),
//             kGapH12,
//             Text("Video không khả dụng",
//                 style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).cardColor))
//           ],
//         );
//       } else {
//         return Chewie(controller: _chewieController!);
//       }
//     });
//   }
// }
