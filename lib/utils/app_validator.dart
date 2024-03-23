class AppValidator{
  String? isEmptyCheck(value){
    if (value!.isEmpty){
      return 'Please fill all details';
    }
    return null;
  }
}