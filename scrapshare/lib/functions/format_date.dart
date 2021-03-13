import 'package:intl/intl.dart';

String formatDate(DateTime date){
  return DateFormat('EEEE, MMMM d, yyyy').format(date);
}
