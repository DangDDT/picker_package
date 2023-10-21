import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../domain/enums/private/image_section.dart';
import '../../domain/enums/private/picker_tab_status.dart';
import '../view_models/state_data_view_model.dart';

class MediaPickerViewModel {
  final Rx<PickerTabStatus> _tabStatus =
      Rx<PickerTabStatus>(PickerTabStatus.empty);
  Rx<PickerTabStatus> get tabStatus => _tabStatus;

  setTabStatus(PickerTabStatus value) {
    if (value != _tabStatus.value) {
      _tabStatus.call(value);
    }
  }

  final Rx<MediaSection> _mediaSection = Rx<MediaSection>(
    MediaSection.noStoragePermission,
  );
  Rx<MediaSection> get mediaSection => _mediaSection;

  void setImageSection(MediaSection value) {
    _mediaSection.call(value);
  }

  final Rx<PermissionState> _permissionStatus =
      Rx<PermissionState>(PermissionState.denied);
  Rx<PermissionState> get permissionStatus => _permissionStatus;

  final Rx<int> _countRequest = Rx<int>(0);
  Rx<int> get countRequest => _countRequest;

  void increaseCountRequest() {
    _countRequest.call(_countRequest.value++);
  }

  void setPermissionStatus(PermissionState value) {
    if (value != _permissionStatus.value) {
      _permissionStatus.call(value);
    }
  }

  final Rx<bool> _detectPermission = Rx<bool>(false);

  Rx<bool> get detectPermission => _detectPermission;

  setDetectPermission(bool value) {
    if (value != _detectPermission.value) {
      _detectPermission.call(value);
    }
  }

  final Rx<ListAssetEntityState> _listAssetEntityState =
      Rx<ListAssetEntityState>(StateDataVM.none<AssetEntityState>(RxList));
  Rx<ListAssetEntityState> get listAssetEntityState => _listAssetEntityState;

  void setLoadingListAssetEntityState() {
    _listAssetEntityState.call(_listAssetEntityState.value.setLoading());
  }

  void setSuccessListAssetEntityState(List<AssetEntityState> data) {
    _listAssetEntityState
        .call(_listAssetEntityState.value.setSuccess(data.obs));
  }

  void setErrorListAssetEntityState(String message) {
    _listAssetEntityState.call(_listAssetEntityState.value.setError(message));
  }

  void setEmptyListAssetEntityState() {
    _listAssetEntityState.call(_listAssetEntityState.value.setEmpty());
  }

  final RxList<AssetEntityResult> selectedAssetEntity =
      RxList<AssetEntityResult>();

  setSelectedAssetEntity(AssetEntityResult value) {
    if (selectedAssetEntity.contains(value)) {
      selectedAssetEntity.remove(value);
    } else {
      selectedAssetEntity.add(value);
    }
  }

  void clearSelectedAssetEntity() {
    selectedAssetEntity.clear();
  }
}

typedef ListAssetEntityState = StateDataVM<RxList<AssetEntityState>>;

typedef AssetEntityState = Rx<StateDataVM<AssetEntityResult?>>;

class AssetEntityResult {
  const AssetEntityResult({
    this.assetEntity,
    this.thumnailByte,
    this.file,
  });
  final AssetEntity? assetEntity;
  final Uint8List? thumnailByte;
  final File? file;
}
