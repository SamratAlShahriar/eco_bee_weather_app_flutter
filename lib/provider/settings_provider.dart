import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SettingsProvider extends ChangeNotifier{

void i()async {
  final list = await locationFromAddress("Gronausestraat 710, Enschede");
  final l = list.first;
  l.latitude;
  l.longitude;
}

}