import 'package:flutter/material.dart';
import 'package:flutter_video/l10n/messages_all.dart';
import 'package:intl/intl.dart';

class MyLocalizations {
  static Future<MyLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new MyLocalizations();
    });
  }

  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, MyLocalizations);
  }

  String get title => Intl.message('Douban Movies',
      name: 'title', desc: 'Title for the application');

  String get theme => Intl.message('Theme', name: 'theme', desc: '');

  String get language => Intl.message('Language', name: 'language', desc: '');

  String get auto => Intl.message('Auto', name: 'Auto', desc: '');
  String get movie => Intl.message('Movie', name: 'movie', desc: '');
  String get tv => Intl.message('Tv', name: 'tv', desc: '');
  String get rank => Intl.message('Rank', name: 'rank', desc: '');
  String get profile => Intl.message('Profile', name: 'profile', desc: '');
  String get waiting => Intl.message('Waiting...', name: 'waiting', desc: '');
  String get blue => Intl.message('Blue', name: 'blue', desc: '');
  String get cyan => Intl.message('Cyan', name: 'cyan', desc: '');
  String get teal => Intl.message('Teal', name: 'teal', desc: '');
  String get green => Intl.message('Green', name: 'green', desc: '');
  String get red => Intl.message('Red', name: 'red', desc: '');
  String get download => Intl.message('Download', name: 'download', desc: '');
  String get downloaded => Intl.message('Downloaded', name: 'downloaded', desc: '');
  String get downloading => Intl.message('Downloading', name: 'downloading', desc: '');
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<MyLocalizations> load(Locale locale) {
    return MyLocalizations.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
