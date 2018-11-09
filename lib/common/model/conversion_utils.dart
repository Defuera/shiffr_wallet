double parseNullableDouble(value) {
  if (value == null) {
    return null;
  } else {
    return value.toDouble();
  }
}
