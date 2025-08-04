extension FormValidatorsExt on String {
  static final RegExp _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  String? get isNameValid {
    if (isEmpty) {
      return 'Nombre requerido.';
    }
    if (length <= 2) {
      return 'Nombre inválido.';
    } else {
      return null;
    }
  }

  String? get isEmailValid {
    if (isEmpty) {
      return 'Correo electrónico requerido.';
    }
    if (!_emailRegExp.hasMatch(this)) {
      return 'Correo electrónico inválido.';
    } else {
      return null;
    }
  }

  String? get isPasswordValid {
    if (isEmpty) {
      return 'Por favor, escribe tu contraseña.';
    }
    if (length <= 7) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    } else {
      return null;
    }
  }

  String? confirmPasswordValidator(String newPassword) {
    if (isEmpty) {
      return 'Por favor, repite la nueva contraseña.';
    }
    if (this != newPassword) {
      return 'Las contraseñas no coinciden.';
    } else {
      return null;
    }
  }
}
