import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/core.dart';
import '../../shared/color_filter_wrapper.dart';
import '../location_picker_controller.dart';

class MyLocationMap extends GetView<LocationPickerController> {
  const MyLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final myLocationData = controller.myLocationData.value;
      return myLocationData == null
          ? const Center(child: CircularProgressIndicator())
          : fm.FlutterMap(
              options: fm.MapOptions(
                center: LatLng(myLocationData.latitude!, myLocationData.longitude!),
                zoom: 18.0,
                boundsOptions: const fm.FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                interactiveFlags: fm.InteractiveFlag.none,
              ),
              children: [
                fm.TileLayer(
                  urlTemplate: "http://mt{s}.google.com/vt/lyrs=r&x={x}&y={y}&z={z}",
                  subdomains: const ['0', '1', '2', '3'],
                  maxZoom: 19,
                  minZoom: 1,
                ),
                fm.MarkerLayer(
                  markers: [
                    fm.Marker(
                      point: LatLng(myLocationData.latitude!, myLocationData.longitude!),
                      builder: (context) => ColorFilteredWrapper(
                        child: LottieBuilder.asset(
                          Assets.core_picker$assets_icons_135726_map_marker_json,
                          fit: BoxFit.fill,
                        ),
                      ),
                      height: 70,
                      width: 70,
                    ),
                  ],
                ),
              ],
            );
    });
  }
}
