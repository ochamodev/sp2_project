import 'package:formz/formz.dart';

enum EmailInputValidationError { invalid }

class EmailInput extends FormzInput<String, EmailInputValidationError>
     {
  const EmailInput.pure([String value = '']) : super.pure(value);

  const EmailInput.dirty([String value = '']) : super.dirty(value);

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
  );

  @override
  EmailInputValidationError? validator(String value) {
    if (isPure) {
      return null;
    } else {
      return _emailRegExp.hasMatch(value) ? null : EmailInputValidationError.invalid;
    }
  }
}

extension Explanation on EmailInputValidationError {
  String text() {
    switch (this) {
      case EmailInputValidationError.invalid:
        return 'El correo ingresado no es valido';
    }
  }
}