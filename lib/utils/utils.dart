List<double> listStringToDoubleConverter(String str) {
  final splitStr = str.split(",");
  final doubleStrList = splitStr.map(double.parse).toList();
  return doubleStrList;
}