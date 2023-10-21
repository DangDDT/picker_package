import 'dart:ui';

import 'package:core_picker/core/core.dart';
import 'package:get/get.dart';

extension LocaleExtension on Locale {
  String get tag => '${languageCode}_$countryCode';
}

class SupportedLocales {
  static Locale get defaultLocale => vi;

  static const Locale vi = Locale('vi', 'VN');

  static const Locale en = Locale('en', 'US');

  static const Locale ja = Locale('ja', 'JP');

  static const Locale zh = Locale('zh', 'CN');
}

class Translator extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        SupportedLocales.vi.tag: {...CorePicker.l10n.vi.message},
        SupportedLocales.en.tag: {...CorePicker.l10n.en.message},
        SupportedLocales.ja.tag: {...CorePicker.l10n.ja.message},
        SupportedLocales.zh.tag: {...CorePicker.l10n.zh.message},
      };
}

enum Language {
  vi('Tiếng Việt', SupportedLocales.vi),
  en('English', SupportedLocales.en),
  ja('日本語', SupportedLocales.ja),
  zh('中文', SupportedLocales.zh);

  const Language(this.title, this.locale);

  final String title;
  final Locale locale;
}
