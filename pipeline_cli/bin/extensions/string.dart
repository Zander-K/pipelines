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
