import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

void initializeIntl() async {
  await findSystemLocale().then((locale) {
    initializeDateFormatting(locale, null);
  });
}

String formatDate(String inputDate) {
  DateTime dateTime = DateTime.parse(inputDate);

  String formattedDate = DateFormat('EEEE, d MMM').format(dateTime);

  formattedDate = formattedDate.replaceAllMapped(RegExp(r'^[A-Za-z]+'), (
    match,
  ) {
    switch (match.group(0)) {
      case 'Monday':
        return 'Lunes';
      case 'Tuesday':
        return 'Martes';
      case 'Wednesday':
        return 'Miércoles';
      case 'Thursday':
        return 'Jueves';
      case 'Friday':
        return 'Viernes';
      case 'Saturday':
        return 'Sábado';
      case 'Sunday':
        return 'Domingo';
      default:
        return match.group(0) ?? '';
    }
  });

  return formattedDate;
}

String formatToHour(String dateTime) {
  final date = DateTime.parse(dateTime);

  final formatted = DateFormat('h:mm a').format(date);

  return formatted.toLowerCase();
}
