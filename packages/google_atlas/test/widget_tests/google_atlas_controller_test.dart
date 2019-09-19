import 'package:atlas/atlas.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_atlas/src/google_atlas_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMaps;
import 'package:mockito/mockito.dart';

class MockGoogleMapController extends Mock
    implements GoogleMaps.GoogleMapController {}

main() {
  group('GoogleAtlasController', () {
    GoogleMaps.GoogleMapController googleMapController;
    GoogleAtlasController googleAtlasController;

    setUp(() {
      googleMapController = MockGoogleMapController();
      googleAtlasController = GoogleAtlasController(
        controller: googleMapController,
      );
    });

    test('throws AssertionError if GoogleMaps.GoogleMapsController is null',
        () {
      try {
        GoogleAtlasController(controller: null);
      } catch (error) {
        expect(error, isAssertionError);
      }
    });

    group('moveCamera', () {
      test('invokes moveCamera', () async {
        final CameraPosition cameraPosition = CameraPosition(
          target: LatLng(latitude: 10.1, longitude: -80.7),
          zoom: 15,
        );
        await googleAtlasController.moveCamera(cameraPosition);
        verify(googleMapController.moveCamera(any)).called(1);
      });
    });

    group('updateBounds', () {
      test('invokes newLatLngBounds', () async {
        final LatLngBounds bounds = LatLngBounds(
          northeast: LatLng(latitude: 1, longitude: 1),
          southwest: LatLng(latitude: 0, longitude: 3),
        );
        await googleAtlasController.updateBounds(bounds, 20);
        verify(googleMapController.moveCamera(any)).called(1);
      });
    });
  });
}