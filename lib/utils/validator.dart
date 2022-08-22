// ignore_for_file: body_might_complete_normally_nullable

String? lengthValidator(String? value, int min, int max) {
  if (value == null ||
      value.isEmpty ||
      value.length < min ||
      value.length > max) {
    return 'Erreur, nombre de caractères minimum $min, maximum $max';
  }
}

String? maxLengthValidator(String? value, int max) {
  if (value != null && value.length > max) {
    return 'Erreur, nombre de caractères maximum $max';
  }
}

String? fieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Erreur, saisie invalide';
  }
}
