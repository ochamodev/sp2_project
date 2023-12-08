
import 'package:formz/formz.dart';

enum TextFieldInputError { empty }

class TextFieldInput extends FormzInput<String, TextFieldInputError> {
  const TextFieldInput.pure({String value = ''}): super.pure(value);
  const TextFieldInput.dirty({String value = ''}) : super.dirty(value);

  @override
  TextFieldInputError? validator(String value) {
      return value.isNotEmpty ? null : TextFieldInputError.empty;
  }
}

extension Explanation on TextFieldInputError {
  String text() {
    switch (this) {
      case TextFieldInputError.empty:
        return 'Campo inválido.';
    }
  }
}
