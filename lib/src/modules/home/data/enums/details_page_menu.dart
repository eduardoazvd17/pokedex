import 'package:localization/localization.dart';

enum DetailsPageMenu {
  about,
  stats,
  evolution,
  moves,
}

extension DetailsPageMenuExtension on DetailsPageMenu {
  String get title => '$name-text'.i18n();
}
