DateTime? fromJsonToLocal(String? date) {
  try {
    return DateTime.parse(date ?? '').toLocal();
  } catch (_) {
    return null;
  }
}

DateTime fromJsonToLocalRequired(String? date) {
  try {
    return DateTime.parse(date ?? '').toLocal();
  } catch (_) {
    return DateTime.now();
  }
}

String? toJsonFromLocal(DateTime? date) {
  if (date == null) {
    return null;
  }
  
  return date.toUtc().toIso8601String();
}
