//! Convert DateTime Obj to String  i.e "yyyymdhhmmss -> (yyyy:mm:dd)"

String convertDateTimeToString(DateTime dateTime) {
  //* Year format -> yyyy

  String year = dateTime.year.toString();

  //* Month format -> mm

  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  //* Day format -> mm

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  //& Combine All to form yyyymmdd

  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
