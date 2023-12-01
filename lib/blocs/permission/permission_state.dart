part of 'permission_bloc.dart';

class PermissionState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;
  final bool isCameraPermissionGranted;
  final bool isPhonePermissionGranted;
  final bool isBackgroundLocationEnabled;
  final bool isDataEnabled;
  bool get isAllGranted =>
      isGpsEnabled &&
      isGpsPermissionGranted &&
      isPhonePermissionGranted &&
      isBackgroundLocationEnabled &&
      //isDataEnabled &&
      isCameraPermissionGranted;

  const PermissionState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
    required this.isPhonePermissionGranted,
    required this.isBackgroundLocationEnabled,
    required this.isDataEnabled,
    required this.isCameraPermissionGranted,
  });

  PermissionState copyWith(
          {bool? isGpsEnabled,
          bool? isGpsPermissionGranted,
          bool? isPhonePermissionGranted,
          bool? isBackgroundLocationEnabled,
          bool? isDataEnabled,
          bool? isSetPhone,
          bool? isCameraPermissionGranted}) =>
      PermissionState(
        isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
        isGpsPermissionGranted:
            isGpsPermissionGranted ?? this.isGpsPermissionGranted,
        isPhonePermissionGranted:
            isPhonePermissionGranted ?? this.isPhonePermissionGranted,
        isBackgroundLocationEnabled:
            isBackgroundLocationEnabled ?? this.isBackgroundLocationEnabled,
        isDataEnabled: isDataEnabled ?? this.isDataEnabled,
        isCameraPermissionGranted:
            isCameraPermissionGranted ?? this.isCameraPermissionGranted,
      );

  @override
  List<Object> get props => [
        isGpsEnabled,
        isGpsPermissionGranted,
        isPhonePermissionGranted,
        isBackgroundLocationEnabled,
        isDataEnabled,
        isCameraPermissionGranted,
      ];

  @override
  String toString() {
    return '{ isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted }';
  }
}
