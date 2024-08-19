import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Remove all non-digit characters
    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');

    // Format digits as 010-xxxx-xxxx
    String formatted = '';
    if (digitsOnly.length > 3) {
      formatted += digitsOnly.substring(0, 3);
      if (digitsOnly.length > 7) {
        formatted += '-${digitsOnly.substring(3, 7)}';
        if (digitsOnly.length > 11) {
          formatted += '-${digitsOnly.substring(7, 11)}';
        } else {
          formatted += '-${digitsOnly.substring(7)}';
        }
      } else {
        formatted += '-${digitsOnly.substring(3)}';
      }
    } else {
      formatted = digitsOnly;
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
