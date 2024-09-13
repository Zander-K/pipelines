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
