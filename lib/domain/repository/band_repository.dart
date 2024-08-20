import 'dart:io';
import '../model/profile/band_model.dart';

abstract class BandRepository {
  Future<List<Band>> getUserBands(String userId);
}
