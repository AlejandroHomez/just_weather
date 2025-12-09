class JwEnumUtils {
  JwEnumUtils._();
  static bool _getEnum(type, String style) => type
      .toString()
      .replaceAll(RegExp(r'^[a-z]+\.', caseSensitive: false), '')
      .contains(style);

  static T getEnum<T>(List<T> values, String style) =>
      values.firstWhere((e) => _getEnum(e, style));
}
