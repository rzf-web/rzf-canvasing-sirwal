mixin class IName {
  String getInitialName(String name) {
    var initialName = "";
    var splitName = name.toUpperCase().split(" ");
    if (splitName.length > 1 && splitName[1] != '') {
      initialName = "${splitName[0][0]}${splitName[1][0]}";
    } else {
      initialName = splitName[0][0];
    }
    return initialName;
  }
}
