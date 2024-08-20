import 'package:band_community/domain/use_case/get_group_profile_image_use_case.dart';
import 'package:band_community/domain/use_case/get_user_profile_image_use_case.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/model/profile/band_model.dart';
import '../../domain/use_case/main/get_band_use_case.dart';

class MainViewModel extends ChangeNotifier {
  final authentication = Supabase.instance.client;
  final GetUserProfileImageUseCase _getUserProfileImageUseCase;
  final GetGroupProfileImageUseCase _getGroupProfileImageUseCase;
  final GetBandsUseCase getBandsUseCase;

  MainViewModel(this._getUserProfileImageUseCase, this._getGroupProfileImageUseCase, this.getBandsUseCase);

  String? userProfileImageUrl;
  List<String> groupProfileImageUrls = [];
  List<Band> bands = [];

  Future<void> loadUserProfileImage() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;
    userProfileImageUrl = await _getUserProfileImageUseCase.execute(userId);
    notifyListeners();
  }

  Future<void> loadGroupProfileImages() async {
    groupProfileImageUrls = List.filled(bands.length, ''); // 빈 문자열로 리스트 초기화
    for (int i = 0; i < bands.length; i++) {
      final groupProfileImageUrl = await _getGroupProfileImageUseCase.execute(bands[i].id);
      groupProfileImageUrls[i] = groupProfileImageUrl ?? '';
    }
    notifyListeners();
  }

  Future<void> loadUserBands(String userId) async {
    bands = await getBandsUseCase.execute(userId);
    await loadGroupProfileImages(); // 밴드가 로드된 후 프로필 이미지 로드
    notifyListeners();
  }
}

