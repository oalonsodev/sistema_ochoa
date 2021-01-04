mixin SelectProviderController {
  //* ======= Variables =======
  //? => Variables
  /// Lista de estados para los CheckBox.
  List<bool> checkList = List.empty(growable: true);

  //* ======= Métodos =======
  /// Agrega un elemento más a checkList.
  addChek() {
    checkList.add(false);
  }

  /// Vacía la lista checkList.
  clearCheck() {
    checkList.clear();
  }
}
