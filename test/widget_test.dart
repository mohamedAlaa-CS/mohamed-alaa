import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mohamed_alaa/core/theme/app_colors.dart';

void main() {
  test('AppColors brand palette verification', () {
    // Assert Editorial Light palette values: Paper Ivory, Espresso, Caramel, TextBody
    expect(AppColors.background, const Color(0xFFFAF7F2));
    expect(AppColors.espresso, const Color(0xFF1A120B));
    expect(AppColors.onSurface, const Color(0xFF1A120B));
    expect(AppColors.caramel, const Color(0xFFB45309));
  });
}
