Map<String, dynamic> removeNullFieldsFromJson(Map<String, dynamic> json) {
  json.removeWhere((key, value) => value == null);

  return json;
}
