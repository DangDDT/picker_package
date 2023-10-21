// import 'package:flutter/material.dart';

// class TepDinhKemImage extends StatefulWidget {
//   const TepDinhKemImage({
//     Key? key,
//     required this.fullImageUrl,
//     required this.index,
//   }) : super(key: key);

//   final int index;
//   final String fullImageUrl;
//   @override
//   State<TepDinhKemImage> createState() => _TepDinhKemImageState();
// }

// class _TepDinhKemImageState extends State<TepDinhKemImage> {
//   late VideoPlayerController _controller;
//   @override
//   void initState() {
//     _controller = VideoPlayerController.network(widget.fullImageUrl)..initialize();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Hero(
//       tag: Key(widget.index.toString() + widget.fullImageUrl),
//       child: Builder(
//         builder: (context) {
//           final fileType = FileHelper.getFileType(widget.fullImageUrl);
//           if (fileType == FileType.image) {
//             return Image.network(
//               widget.fullImageUrl,
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   width: 100,
//                   color: theme.disabledColor.withOpacity(.1),
//                   child: Center(
//                     child: Icon(Icons.error, color: theme.hintColor),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return SizedBox(
//               height: 100,
//               width: 100,
//               child: Stack(children: [
//                 VideoPlayer(
//                   _controller,
//                 ),
//                 Align(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: theme.disabledColor,
//                     ),
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: theme.cardColor,
//                     ),
//                   ),
//                 )
//               ]),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
