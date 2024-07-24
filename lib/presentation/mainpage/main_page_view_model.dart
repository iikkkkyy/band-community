import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainViewModel extends ChangeNotifier {
  final authentication = Supabase.instance.client;

}
