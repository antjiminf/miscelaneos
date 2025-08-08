import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider =
    StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
      return PermissionsNotifier();
    });

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier() : super(PermissionsState());

  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
      Permission.sensors.status,
    ]);

    state = state.copyWith(
      camera: permissionsArray[0],
      gallery: permissionsArray[1],
      location: permissionsArray[2],
      locationAlways: permissionsArray[3],
      locationWhenInUse: permissionsArray[4],
      sensors: permissionsArray[5],
    );
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    _checkPermissionStatus(status);
  }

  requestGalleryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(gallery: status);

    _checkPermissionStatus(status);
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    _checkPermissionStatus(status);
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    _checkPermissionStatus(status);
  }

  void _checkPermissionStatus(PermissionStatus status) {
    if (status == PermissionStatus.permanentlyDenied) {
      openSettings();
    }
  }

  openSettings() {
    openAppSettings();
  }
}

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus gallery;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
    this.camera = PermissionStatus.denied,
    this.gallery = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  get cameraGranted {
    return camera == PermissionStatus.granted;
  }

  get galleryGranted {
    return gallery == PermissionStatus.granted;
  }

  get locationGranted {
    return location == PermissionStatus.granted;
  }

  get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }

  get locationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }

  get sensorsGranted {
    return sensors == PermissionStatus.granted;
  }

  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? gallery,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
    PermissionStatus? sensors,
  }) => PermissionsState(
    camera: camera ?? this.camera,
    gallery: gallery ?? this.gallery,
    location: location ?? this.location,
    locationAlways: locationAlways ?? this.locationAlways,
    locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
    sensors: sensors ?? this.sensors,
  );
}
