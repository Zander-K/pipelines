extension GetString on String? {
  bool get isNull {
    final value = this;

    if (value != null) {
      return false;
    } else {
      return true;
    }
  }
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullAndNotEmpty => this?.isNotEmpty ?? false;
}

extension CapitalizeString on String? {
  String? get capitalized {
    final value = this;

    final firstLetter = value?.substring(0, 1) ?? '';

    final result = value?.replaceRange(0, 1, firstLetter.toUpperCase());

    return result;
  }
}
