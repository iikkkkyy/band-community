import 'package:band_community/domain/use_case/get_user_profile_image_use_case.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainViewModel extends ChangeNotifier {
  final authentication = Supabase.instance.client;
  final GetUserProfileImageUseCase _getUserProfileImageUseCase;

  MainViewModel(this._getUserProfileImageUseCase);

  String? userProfileImageUrl;

  Future<void> loadUserProfileImage() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    userProfileImageUrl = await _getUserProfileImageUseCase.execute(userId);
    notifyListeners();
  }
}
