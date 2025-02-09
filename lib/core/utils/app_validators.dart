class AppValidator{
  static String? validateText({required String? value,required String? isEmptyErrorMessage}) {
    if (value!.isEmpty && value.trim().isEmpty) {
      return isEmptyErrorMessage;
    }

    return null;
  }
}