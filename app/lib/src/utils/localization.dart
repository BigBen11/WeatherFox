import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A simple placeholder that can be used to search all the hardcoded strings
/// in the code (useful to identify strings that need to be localized).
/// thanks to https://github.com/bizz84/starter_architecture_flutter_firebase/blob/master/lib/src/localization/string_hardcoded.dart
extension StringHardcoded on String {
  String get hardcoded => this;
}

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc {
    final localizations = AppLocalizations.of(this);
    assert(localizations != null, 'No AppLocalizations found in the context');
    return localizations!;
  }
}
