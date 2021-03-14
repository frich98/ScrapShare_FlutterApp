import '../functions/format_date.dart';

class Post {

  DateTime date;
  String imageURL;
  int quantity;
  double latitude;
  double longitude;

  Post({this.date, this.imageURL, this.quantity, this.latitude, this.longitude});

  String getFormattedPostDate(){
    return formatDate(date);
  }
  
  String getRoundedLatitudeString(){
    return latitude.toStringAsFixed(3);
  }
  String getRoundedLongitudeString(){
    return longitude.toStringAsFixed(3);
  }
}