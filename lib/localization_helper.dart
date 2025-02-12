import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LocalizationHelper {
  static String getText(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return key;

    switch (key) {
      case 'all':
        return localizations.all;
      case 'sport':
        return localizations.sport;
      case 'birthday':
        return localizations.birthday;
      case 'meeting':
        return localizations.meeting;
      case 'gaming':
        return localizations.gaming;
      case 'eating':
        return localizations.eating;
      case 'holiday':
        return localizations.holiday;
      case 'exhibition':
        return localizations.exhibition;
      case 'workshop':
        return localizations.workshop;
      case 'book_club':
        return localizations.book_club;
      default:
        return key;
    }
  }
}
