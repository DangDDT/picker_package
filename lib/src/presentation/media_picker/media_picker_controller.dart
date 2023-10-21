import 'dart:io';

import 'package:core_picker/src/presentation/camera_thumbnail/camera_thumbnail_controller.dart';
import 'package:core_picker/src/presentation/picker_menu/picker_menu_controller.dart';
import 'package:core_picker/src/presentation/picker_menu/widgets/cancel_confirm_dialog.dart';
import 'package:core_picker/src/presentation/view_models/state_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vif_previewer/previewer.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../@base/tab_picker_controller.dart';
import 'media_picker_view_model.dart';

class MediaPickerController extends GetxController
    with WidgetsBindingObserver, PagingMixin
    implements TabPickerController {
  late final MediaPickerViewModel _imageModel;

  MediaPickerViewModel get imageModel => _imageModel;

  final ModuleConfig _config =
      Get.find<ModuleConfig>(tag: CorePicker.packageName);
  ModuleConfig get config => _config;

  bool get isMultiSelection =>
      config.mediaPickerOption?.isMultiSelection ?? true;

  List<MediaPickerType> get mediaPickerTypes =>
      config.mediaPickerOption?.mediaPickerTypes ??
      const [MediaPickerType.image, MediaPickerType.video];

  @override
  ScrollController? scrollController;

  @override
  int get pageSize =>
      config.mediaPickerOption?.maxMediaPerLoadTime ??
      DefaultPickerConstants.defaultMaxImagePerLoad;

  final Rxn<int> _isLongPressState = Rxn<int>();
  Rxn<int> get isLongPressState => _isLongPressState;

  final Rxn<int> _isDoubleTap = Rxn<int>();
  Rxn<int> get isDoubleTap => _isDoubleTap;

  @override
  onInit() {
    _imageModel = MediaPickerViewModel();
    requestFilePermission();
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        imageModel.detectPermission.value &&
        (imageModel.mediaSection.value ==
            MediaSection.noStoragePermissionPermanent)) {
      imageModel.setDetectPermission(false);
      requestFilePermission();
    } else if (state == AppLifecycleState.paused &&
        imageModel.mediaSection.value ==
            MediaSection.noStoragePermissionPermanent) {
      imageModel.setDetectPermission(true);
    }
    super.didChangeAppLifecycleState(state);
    Logger.logInfo('didChangeAppLifecycleState: $state',
        name: 'ImagePickerController|didChangeAppLifecycleState');
  }

  Future<void> requestFilePermission() async {
    final PermissionState result;
    Logger.logInfo(
      "Current status: ${imageModel.permissionStatus}",
      name: 'ImagePickerController|requestFilePermission',
    );
    result = await PhotoManager.requestPermissionExtend();
    Logger.logInfo(
      "Request status: $result",
      name: 'ImagePickerController|requestFilePermission',
    );
    if (result.isAuth) {
      imageModel.setImageSection(MediaSection.browseFiles);
      await fetchItems();
    } else {
      imageModel.setImageSection(MediaSection.noStoragePermission);
    }
    imageModel.setPermissionStatus(result);
    imageModel.increaseCountRequest();
  }

  @override
  Future<void> fetchItems() async {
    if (getFirstData) {
      imageModel.setLoadingListAssetEntityState();
    }
    if (lastPage) {
      return;
    }
    try {
      final List<AssetPathEntity> listAssetPathEntity =
          await PhotoManager.getAssetPathList(
        type: mediaPickerTypes.mapToPhotoManagerRequestType,
        onlyAll: true,
      );
      final List<AssetEntity> listAssetEntityData =
          await listAssetPathEntity.first.getAssetListPaged(
        page: currentPage,
        size: pageSize,
      );
      if (listAssetEntityData.isEmpty ||
          listAssetEntityData.length < pageSize) {
        setLastPage = true;
      }

      final List<AssetEntityState> newListAssetEntityState = listAssetEntityData
          .map((e) => StateDataVM<AssetEntityResult>(
                  AssetEntityResult(assetEntity: e, thumnailByte: null), null)
              .obs)
          .toList();
      if (getFirstData) {
        if (newListAssetEntityState.isEmpty) {
          imageModel.setEmptyListAssetEntityState();
          return;
        }
        imageModel.setSuccessListAssetEntityState(newListAssetEntityState);
        setFirstData = false;
      } else {
        imageModel.listAssetEntityState.value.data
            ?.addAll(newListAssetEntityState);
      }
      if (newListAssetEntityState.isNotEmpty) {
        await _loadItem(newListAssetEntityState.obs);
      }
      Logger.logOK(
        'fetchItems: ${imageModel.listAssetEntityState.value.data?.length}',
        name: 'ImagePickerViewModel.fetchItems',
      );
    } catch (e, stackTrace) {
      if (e is StateError) {
        ///NOTE: This error is thrown when not found any asset
        imageModel.setEmptyListAssetEntityState();
        return;
      }
      Logger.logInfo(e.toString(),
          name: 'ImagePickerViewModel._fetchAsset', stackTrace: stackTrace);
      imageModel.setErrorListAssetEntityState(e.toString());
    }
  }

  Future<void> _loadItem(RxList<AssetEntityState> list) async {
    try {
      if (imageModel.listAssetEntityState.value.data == null) {
        throw ValidationException(
          ValidationExceptionKind.invalidOutput,
          message: 'listAssetEntityState.data is null',
        );
      }
      for (AssetEntityState asset in list) {
        try {
          asset.call(asset.value.setLoading());
          final AssetEntity? assetEntity = asset.value.data?.assetEntity;
          if (assetEntity == null) {
            asset.call(asset.value.setError('assetEntity is null'));
          }
          final file = await assetEntity?.file;
          final byte = await assetEntity?.thumbnailDataWithSize(
              const ThumbnailSize.square(200),
              quality: 30);

          if (byte == null) {
            asset.call(asset.value.setError('byte is null'));
          }
          asset.call(
            asset.value.setSuccess(
              AssetEntityResult(
                assetEntity: assetEntity,
                thumnailByte: byte,
                file: file,
              ),
            ),
          );
        } catch (e) {
          asset.call(asset.value.setError(e.toString()));
          Logger.logInfo(e.toString(), name: 'ImagePickerViewModel.loadItem');
        }
      }
    } on ValidationException catch (e) {
      if (e.kind == ValidationExceptionKind.invalidOutput &&
          e.message == 'listAssetEntityState.data is null') {
        Logger.logInfo(e.toString(), name: 'ImagePickerViewModel.loadItem');
      }
    }
  }

  Future<void> onImageTap(AssetEntityResult pickedImage) async {
    if (pickedImage.assetEntity == null || pickedImage.thumnailByte == null) {
      return;
    }

    imageModel.setSelectedAssetEntity(pickedImage);
    final setResult = imageModel.selectedAssetEntity
        .map(
          (e) async => MediaAttachmentData(
            e.thumnailByte,
            e.file,
            MediaType.image,
          ),
        )
        .toList();
    selectedResult.call(await Future.wait(setResult));
  }

  Future<void> onLongPressImage(
      AssetEntityResult pickedImage, int index) async {
    _isLongPressState.call(index);
  }

  Future<void> onLongPressImageEnd(
      AssetEntityResult pickedImage, int index) async {
    _isLongPressState.value = null;
  }

  Future<void> onImageDoubleTap(
      AssetEntityResult pickedImage, int index) async {
    _isDoubleTap.call(index);
    final List<Rx<StateDataVM<AssetEntityResult?>>> listAssetEntityResult =
        imageModel.listAssetEntityState.value.data ?? [];
    final List<MediaPreviewData> mediaList = [];
    for (final asset in listAssetEntityResult) {
      if (asset.value.data?.assetEntity == null) {
        continue;
      }
      mediaList.add(
        MediaPreviewData.fromFile(
          file: asset.value.data?.file ?? File(''),
          type:
              asset.value.data?.assetEntity?.type.mediaType ?? MediaType.image,
          heroTag: ValueKey(asset.value.data?.assetEntity?.id),
        ),
      );
    }
    await Future.delayed(const Duration(milliseconds: 210), () async {
      _isDoubleTap.value = null;
    });
    await Future.delayed(const Duration(milliseconds: 110), () async {
      Get.toNamed(
        previewRoute,
        arguments: {
          'data': mediaList,
          'isPaging': true,
          'pagingConfig': MediaPagingConfig(
            pageSize: _config.mediaPickerOption?.maxMediaPerLoadTime ??
                DefaultPickerConstants.defaultMaxImagePerLoad,
            fetchPage: (page) async {
              final mediaList = <MediaPreviewData>[];
              try {
                await nextPage();
                final List<Rx<StateDataVM<AssetEntityResult?>>>?
                    listAssetEntityResult = imageModel
                        .listAssetEntityState.value.data
                        ?.skip(currentPage * pageSize)
                        .take(pageSize)
                        .toList();
                if (listAssetEntityResult == null) {
                  return mediaList;
                }
                for (final asset in listAssetEntityResult) {
                  if (asset.value.data?.assetEntity == null) {
                    continue;
                  }
                  mediaList.add(
                    MediaPreviewData.fromFile(
                      file: asset.value.data?.file ?? File(''),
                      type: asset.value.data?.assetEntity?.type.mediaType ??
                          MediaType.image,
                      heroTag: index,
                    ),
                  );
                }
                Logger.logInfo('fetchPage: ${mediaList.length}',
                    name: 'ImagePickerViewModel.onImageLongPress');
              } catch (e) {
                Logger.log(e.toString(),
                    name: 'ImagePickerViewModel.onImageLongPress');
              }
              return mediaList;
            },
            firstPageIndex: 0,
          ),
          'onScrollToItem': (int index, MediaPreviewData item) {
            final anchor = DefaultPickerConstants.defaultImagePerRow +
                (_config.mediaPickerOption?.isUseCamera ?? false ? 1 : 0);
            if (index % anchor == 0) {
              final rowHeight =
                  (Get.width / DefaultPickerConstants.defaultImagePerRow);
              final jumpToStep = (index / anchor) * rowHeight;
              scrollController?.jumpTo(jumpToStep);
            }
          },
          'initialIndex': index,
        },
      );
    });
  }

  @override
  void onCloseTab() {
    imageModel.clearSelectedAssetEntity();
  }

  @override
  Future<List<AttachmentData>> onSubmit() async {
    final listMediaTask = imageModel.selectedAssetEntity
        .map(
          (e) async => MediaAttachmentData(
            e.thumnailByte,
            e.file,
            e.assetEntity?.type.mediaType,
          ),
        )
        .toList();
    return await Future.wait(listMediaTask);
  }

  @override
  AttachmentType get attachmentType => AttachmentType.media;

  @override
  RxList<AttachmentData> selectedResult = RxList<AttachmentData>();

  onPickCamera() async {
    final cameraThumbnailController = Get.find<CameraThumbnailController>();
    final cameras = cameraThumbnailController.cameras;
    if (cameras.isEmpty) {
      return;
    }
    final result = await Get.toNamed(
      goCameraRoute,
      arguments: {"cameras": cameras},
      preventDuplicates: false,
    ) as PreviewReturnValue?;
    if (result == null) {
      await Future.delayed(const Duration(milliseconds: 60), () async {
        await cameraThumbnailController.onInit();
      });
      return;
    } else {
      final AssetEntityResult assetEntityResult = AssetEntityResult(
        assetEntity: AssetEntity(
          id: result.file?.name ?? 'unknown',
          typeInt: AssetType.image.index,
          width: 0,
          height: 0,
        ),
        thumnailByte: result.bytes,
      );
      final file = File(result.file?.path ?? 'unknown');
      final mapToImageAttachmentDataResult = [assetEntityResult]
          .map(
            (e) async => MediaAttachmentData(
              e.thumnailByte,
              file,
              result.mediaType,
            ),
          )
          .toList();
      final data = await Future.wait(mapToImageAttachmentDataResult);
      final mapToAttachmentResult = AttachmentResult(
        type: AttachmentType.media,
        data: data,
        caption: result.caption,
        itemCount: data.length,
        selectedTime: DateTime.now(),
      );
      Get.back(result: mapToAttachmentResult);
    }
  }

  @override
  Future<void> onClearSelectedResult() async {
    selectedResult.clear();
    imageModel.clearSelectedAssetEntity();
  }

  @override
  Future<void> onBack() async {
    if (selectedResult.isEmpty) {
      Get.back();
      return;
    }
    final isPop = await Get.dialog<bool?>(const CancelConfirmDialog());
    if (isPop == true) {
      Get.back();
    }
  }

  @override
  void onHeaderVerticalDragUpdate(DragUpdateDetails details) {
    if (isClosed) return;
    Get.find<PickerMenuController>().onHeaderVerticalDragUpdate.call(details);
  }

  @override
  Future<void> onHeaderVerticalDragEnd(DragEndDetails details) async {
    if (isClosed) return;
    final pickerMenuController = Get.find<PickerMenuController>();
    pickerMenuController.onHeaderVerticalDragEnd.call(details);
  }
}
