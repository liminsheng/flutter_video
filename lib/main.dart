import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_video/common/global.dart';
import 'package:flutter_video/l10n/localization_intl.dart';
import 'package:flutter_video/routes/download_zone_route.dart';
import 'package:flutter_video/routes/home_route.dart';
import 'package:flutter_video/routes/language_route.dart';
import 'package:flutter_video/routes/movie_route.dart';
import 'package:flutter_video/routes/profile_route.dart';
import 'package:flutter_video/routes/rank_route.dart';
import 'package:flutter_video/routes/theme_change_route.dart';
import 'package:flutter_video/routes/top_route.dart';
import 'package:flutter_video/routes/tv_route.dart';
import 'package:flutter_video/states/locale_model.dart';
import 'package:flutter_video/states/theme_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, ThemeModel themeModel,
            LocaleModel localeModel, Widget child) {
          return MaterialApp(
            theme: ThemeData(primarySwatch: themeModel.theme),
            onGenerateTitle: (context) {
              return MyLocalizations.of(context).title;
            },
            locale: localeModel.getLocale(),
            supportedLocales: [
              Locale('en', 'US'),
              Locale('zh', 'CN'),
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              MyLocalizationsDelegate()
            ],
            localeResolutionCallback:
                (Locale _locale, Iterable<Locale> supportedLocales) {
              if (localeModel.getLocale() != null) {
                return localeModel.getLocale();
              } else {
                Locale locale;
                if (supportedLocales.contains(_locale)) {
                  locale = _locale;
                } else {
                  locale = Locale('zh', 'CN');
                }
                return locale;
              }
            },
            home: HomeRoute(),
            routes: {
              'movie': (context) => MovieRoute(),
              'tv': (context) => TvRoute(),
              'rank': (context) => RankRoute(),
              'profile': (context) => ProfileRoute(),
              'themes': (context) => ThemeChangeRoute(),
              'language': (context) => LanguageRoute(),
              'top': (context) => TopRoute(),
              'downloadZone': (context) => DownloadZoneRoute(),
            },
          );
        },
      ),
    );
  }
}
