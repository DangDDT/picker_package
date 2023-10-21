// import 'dart:developer';
// import 'dart:io';
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart' as path;
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:phong_hop_khong_giay/common/collections/data_helpers/state_data.dart';
// import 'package:phong_hop_khong_giay/common/collections/enum/enum.dart';
// import 'package:vif_flutter_base/vif_flutter_base.dart';

// class ImageView extends StatefulWidget {
//   final int initialIndex;
//   final List<String> listImage;
//   final List<String> listDownloadImage;
//   const ImageView({
//     super.key,
//     required this.initialIndex,
//     required this.listImage,
//     required this.listDownloadImage,
//   });

//   @override
//   State<ImageView> createState() => _ImageViewState();
// }

// class _ImageViewState extends State<ImageView> {
//   late int _current;
//   late PageController _controller;
//   final StateData<String?> _fileDownloadCurrent = StateData(null);

//   void setFileDownloadCurrent(LoadingState state, String? data) {
//     setState(() {
//       _fileDownloadCurrent.state = state;
//       _fileDownloadCurrent.data = data;
//     });
//   }

//   @override
//   void initState() {
//     log(widget.listImage.toString(), name: "LIST_IMAGE");
//     _current = widget.initialIndex;
//     _controller = PageController(initialPage: _current);
//     checkFileExisted(fileUrl: widget.listImage[_current]);
//     super.initState();
//   }

//   Future<void> onTapDownload({required String fileUrl}) async {
//     try {
//       var tempDir = await getTemporaryDirectory();
//       String fullPath = "${tempDir.path}/${path.basename(fileUrl)}";
//       await VIFBase.I.downloader.download(
//         categorize: "PHANANH",
//         fileID: fileUrl,
//         fileName: path.basename(fileUrl),
//         saveDir: fullPath,
//       );
//       // DownloadHelper.download2(fileUrl, fullPath);
//       checkFileExisted(fileUrl: fullPath);
//     } catch (e) {
//       log(e.toString(), name: "DOWNLOAD_FILE_FAILED");
//       VIFBase.I.toast.show(context, "Tải về thất bại, vui lòng thử lại sau !!!");
//     }
//   }

//   Future<String?> checkFileExisted({required String fileUrl}) async {
//     setFileDownloadCurrent(LoadingState.loading, null);
//     try {
//       var tempDir = await getTemporaryDirectory();
//       String fullPath = "${tempDir.path}/${path.basename(fileUrl)}";
//       File file = File(fullPath);
//       if (await file.exists()) {
//         setFileDownloadCurrent(LoadingState.success, fullPath);
//         return fullPath;
//       }
//       setFileDownloadCurrent(LoadingState.success, null);
//       return null;
//     } catch (e) {
//       log(e.toString(), name: "CHECK_FILE_EXISTED_FAILED");
//       setFileDownloadCurrent(LoadingState.failed, null);
//       return null;
//     }
//   }

//   Future<void> delete({required String fileUrl}) async {
//     try {
//       var tempDir = await getTemporaryDirectory();
//       String fullPath = "${tempDir.path}/${path.basename(fileUrl)}";
//       File file = File(fullPath);
//       if (await file.exists()) file.delete();
//       return;
//     } catch (e) {
//       log(e.toString(), name: "CHECK_FILE_EXISTED_FAILED");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         actions: [
//           _buildIndexIndicatior(context),
//           const SizedBox(width: 12),
//           _buildDownloadButton(),
//         ],
//         backgroundColor: Colors.transparent,
//       ),
//       body: PhotoViewGallery.builder(
//         scrollPhysics: const BouncingScrollPhysics(),
//         builder: (BuildContext context, int index) {
//           final item = widget.listImage[index];
//           final fileType = FileHelper.getFileType(item);
//           if (fileType == FileType.image) {
//             return PhotoViewGalleryPageOptions(
//                 imageProvider: NetworkImage(item),
//                 initialScale: PhotoViewComputedScale.contained,
//                 heroAttributes: PhotoViewHeroAttributes(tag: Key(index.toString() + item)),
//                 errorBuilder: (ctx, _, __) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.error,
//                         color: Theme.of(context).colorScheme.error,
//                       ),
//                       kGapH12,
//                       Text("Tệp đính kèm không khả dụng",
//                           style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).cardColor))
//                     ],
//                   );
//                 });
//           } else if (fileType == FileType.video) {
//             return PhotoViewGalleryPageOptions.customChild(
//               child: MyVideoPlayer(url: item),
//             );
//           } else {
//             return PhotoViewGalleryPageOptions.customChild(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.error,
//                     color: Theme.of(context).colorScheme.error,
//                   ),
//                   kGapH12,
//                   Text(
//                     "Tệp đính kèm không khả dụng",
//                     style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).cardColor),
//                   )
//                 ],
//               ),
//             );
//           }
//         },
//         itemCount: widget.listImage.length,
//         loadingBuilder: (context, event) => Center(
//           child: SizedBox(
//             width: 20.0,
//             height: 20.0,
//             child: CircularProgressIndicator(
//               value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
//             ),
//           ),
//         ),
//         pageController: _controller,
//         onPageChanged: (value) {
//           checkFileExisted(fileUrl: widget.listImage[_current]);
//           setState(() {
//             _current = value;
//           });
//         },
//       ),
//     );
//   }

//   Center _buildIndexIndicatior(BuildContext context) {
//     return Center(
//       child: AnimatedContainer(
//         duration: const Duration(microseconds: 410),
//         child: Text(
//           "${_current + 1}/${widget.listImage.length}",
//           style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                 color: Theme.of(context).cardColor,
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDownloadButton() {
//     return SizedBox(
//       width: 40,
//       height: 40,
//       child: Builder(
//         builder: (context) {
//           if (_fileDownloadCurrent.state == LoadingState.loading ||
//               _fileDownloadCurrent.state == LoadingState.initial) {
//             return Center(child: VIFBase.I.baseWidgets.loadingComponent());
//           } else {
//             final currentItem = widget.listDownloadImage[_current];
//             return IconButton(
//               onPressed: _fileDownloadCurrent.data == null
//                   ? () => onTapDownload(fileUrl: currentItem)
//                   : () => VIFBase.I.fileHelper.open(_fileDownloadCurrent.data!),
//               icon: Icon(
//                 _fileDownloadCurrent.data == null ? Icons.download : Icons.open_in_new,
//                 color: Theme.of(context).cardColor,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
