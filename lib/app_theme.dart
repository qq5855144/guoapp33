import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'liquid_glass.dart';

abstract final class AppTheme {
  static final light = _theme(Brightness.light);
  static final dark = _theme(Brightness.dark);
  static final iosLight = _glass(Brightness.light, TargetPlatform.iOS);
  static final iosDark = _glass(Brightness.dark, TargetPlatform.iOS);
  static final _glassThemes = <(TargetPlatform, Brightness), ThemeData>{};

  static ThemeData get platformLight => _platformTheme(Brightness.light);
  static ThemeData get platformDark => _platformTheme(Brightness.dark);

  static ThemeData _platformTheme(Brightness brightness) {
    final platform = defaultTargetPlatform;
    if (platform == TargetPlatform.iOS) {
      return brightness == Brightness.dark ? iosDark : iosLight;
    }
    if (platform == TargetPlatform.android ||
        platform == TargetPlatform.windows) {
      return _glassThemes.putIfAbsent((
        platform,
        brightness,
      ), () => _glass(brightness, platform));
    }
    return brightness == Brightness.dark ? dark : light;
  }

  static ThemeMode mode(String preference) => switch (preference) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  static String label(String preference) => switch (preference) {
    'light' => '浅色',
    'dark' => '深色',
    _ => '跟随系统',
  };

  static SystemUiOverlayStyle systemBars(Brightness brightness) {
    final icons = brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: icons,
      statusBarBrightness: brightness,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: icons,
      systemNavigationBarContrastEnforced: false,
    );
  }

  static ThemeData _theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final background = dark
        ? const Color(0xFF111420)
        : const Color(0xFFF4F5FA);
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7665EA),
      brightness: brightness,
      primary: dark ? const Color(0xFFAA9CFF) : const Color(0xFF5E4ACF),
      onPrimary: Colors.white,
      primaryContainer: dark
          ? const Color(0xFF332D55)
          : const Color(0xFFE8E4FF),
      onPrimaryContainer: dark
          ? const Color(0xFFE8E4FF)
          : const Color(0xFF2D245E),
      tertiary: dark ? const Color(0xFFF2C66D) : const Color(0xFF94610D),
      surface: dark ? const Color(0xFF1B2030) : Colors.white,
      onSurface: dark ? const Color(0xFFF6F4FF) : const Color(0xFF20233A),
      onSurfaceVariant: dark
          ? const Color(0xFFADB0C6)
          : const Color(0xFF6D7188),
      outline: dark ? const Color(0xFF555D78) : const Color(0xFFC8CDE0),
      outlineVariant: dark ? const Color(0xFF30364A) : const Color(0xFFE1E4F0),
      surfaceContainerLowest: dark ? const Color(0xFF0C0F18) : Colors.white,
      surfaceContainerLow: dark
          ? const Color(0xFF151A27)
          : const Color(0xFFF0F2F9),
      surfaceContainer: dark
          ? const Color(0xFF1B2030)
          : const Color(0xFFE9ECF5),
      surfaceContainerHigh: dark
          ? const Color(0xFF252B3E)
          : const Color(0xFFE2E6F1),
      surfaceContainerHighest: dark
          ? const Color(0xFF31384F)
          : const Color(0xFFD8DDED),
      surfaceTint: Colors.transparent,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: scheme.onSurface,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: systemBars(brightness),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: background,
        useIndicator: false,
        selectedIconTheme: IconThemeData(color: scheme.primary),
        unselectedIconTheme: IconThemeData(color: scheme.onSurfaceVariant),
        selectedLabelTextStyle: TextStyle(
          color: scheme.primary,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle: TextStyle(color: scheme.onSurfaceVariant),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static ThemeData _glass(Brightness brightness, TargetPlatform platform) {
    final dark = brightness == Brightness.dark;
    final ios = platform == TargetPlatform.iOS;
    final background = dark
        ? ios
              ? Colors.black
              : const Color(0xFF111420)
        : const Color(0xFFF4F5FA);
    final primary = dark ? const Color(0xFFAA9CFF) : const Color(0xFF5E4ACF);
    final label = dark ? const Color(0xFFF6F4FF) : const Color(0xFF20233A);
    final secondary = dark
        ? const Color(0xFFADB0C6)
        : const Color(0xFF6D7188);
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: dark
          ? const Color(0xFF332D55)
          : const Color(0xFFE8E4FF),
      onPrimaryContainer: dark
          ? const Color(0xFFE8E4FF)
          : const Color(0xFF2D245E),
      secondaryContainer: dark
          ? const Color(0xFF272B3B)
          : const Color(0xFFE8EAF6),
      onSecondaryContainer: label,
      tertiary: dark ? const Color(0xFFF2C66D) : const Color(0xFF94610D),
      surface: dark ? const Color(0xFF1B2030) : Colors.white,
      onSurface: label,
      onSurfaceVariant: secondary,
      outline: dark ? const Color(0xFF555D78) : const Color(0xFFC8CDE0),
      outlineVariant: dark ? const Color(0xFF30364A) : const Color(0xFFE1E4F0),
      surfaceContainerLowest: dark ? const Color(0xFF0C0F18) : Colors.white,
      surfaceContainerLow: dark
          ? const Color(0xFF151A27)
          : const Color(0xFFF0F2F9),
      surfaceContainer: dark
          ? const Color(0xFF1B2030)
          : const Color(0xFFE9ECF5),
      surfaceContainerHigh: dark
          ? const Color(0xFF252B3E)
          : const Color(0xFFE2E6F1),
      surfaceContainerHighest: dark
          ? const Color(0xFF31384F)
          : const Color(0xFFD8DDED),
      surfaceTint: Colors.transparent,
    );
    const continuous = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(18)),
    );
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      platform: platform,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: label.withValues(alpha: .06),
      hoverColor: label.withValues(alpha: .04),
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
        brightness: brightness,
        primaryColor: primary,
        scaffoldBackgroundColor: background,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: label,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: label,
        ),
        systemOverlayStyle: systemBars(brightness),
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) =>
            const GlassBackIcon(icon: LucideIcons.chevronLeft),
        closeButtonIconBuilder: (_) => const GlassBackIcon(icon: LucideIcons.x),
      ),
      iconTheme: IconThemeData(color: label),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: .5,
        space: .5,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: dark
            ? const Color(0xFF1C1C1E)
            : const Color(0xFFEAE8E5),
        selectedColor: label,
        disabledColor: scheme.surfaceContainer,
        showCheckmark: false,
        side: BorderSide.none,
        shape: ios
            ? const StadiumBorder()
            : const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: WidgetStateColor.resolveWith(
            (states) =>
                states.contains(WidgetState.selected) ? background : label,
          ),
        ),
        secondaryLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: background,
        ),
        iconTheme: IconThemeData(color: secondary, size: 16),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? const Color(0xFF1C1C1E) : const Color(0xFFEAE8E5),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        hintStyle: TextStyle(color: secondary),
        prefixIconColor: secondary,
        suffixIconColor: secondary,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
          minimumSize: const Size(64, 50),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: BorderSide(color: scheme.outline),
          minimumSize: const Size(64, 44),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: dark ? const Color(0xFF1C1C1E) : Colors.white,
        shape: continuous,
        clipBehavior: Clip.antiAlias,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: secondary,
        shape: continuous,
        titleTextStyle: TextStyle(fontSize: 17, letterSpacing: 0, color: label),
        subtitleTextStyle: TextStyle(fontSize: 13, color: secondary),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: dark ? const Color(0xFF232325) : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: dark ? const Color(0xFF252527) : Colors.white,
        elevation: 12,
        shadowColor: Colors.black.withValues(alpha: .3),
        shape: continuous,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: dark ? const Color(0xFF1C1C1E) : Colors.white,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: dark
            ? const Color(0xFF2C2C2E)
            : const Color(0xFF1C1C1E),
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 15),
        actionTextColor: primary,
        shape: continuous,
        elevation: 0,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: Colors.transparent,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: background,
        useIndicator: false,
        selectedIconTheme: IconThemeData(color: primary),
        unselectedIconTheme: IconThemeData(color: secondary),
      ),
    );
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        titleLarge: base.textTheme.titleLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
        titleMedium: base.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
