import 'package:test/test.dart';

import 'package:scrapshare/models/post.dart';

// To run in terminal, while in project folder --->  flutter test test/test_model_post_class.dart

void main (){

  test('Post values created from given constructor values should match given values', (){

    final date = DateTime.parse('2013-01-01');
    const imageURL = 'FAKE_URL';
    const quantity = 100;
    const latitude = 100.100;
    const longitude = 150.150150;

    final  post = Post(date: date, imageURL: imageURL, quantity: quantity, latitude: latitude, longitude: longitude);

    expect(post.date, date);
    expect(post.imageURL, imageURL);
    expect(post.quantity, quantity);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
  });

  test('Check that post date is formatted correctly in the _getPostDate function', (){

    final date = DateTime.parse('2016-02-29');
    const imageURL = 'FAKE_URL';
    const quantity = 100;
    const latitude = 100.100;
    const longitude = 150.150150;

    final  post = Post(date: date, imageURL: imageURL, quantity: quantity, latitude: latitude, longitude: longitude);

    expect(post.getFormattedPostDate(), "Monday, February 29, 2016");
  });

  test('Check that the latitude is rounded correctly and get function returns a string', (){

    final date = DateTime.parse('2016-02-29');
    const imageURL = 'FAKE_URL';
    const quantity = 100;
    const latitude = 100.1985792222;
    const longitude = 150.150150;

    final  post = Post(date: date, imageURL: imageURL, quantity: quantity, latitude: latitude, longitude: longitude);

    expect(post.getRoundedLatitudeString(), "100.199");
  });

  test('Check that the longitude is rounded correctly and get function returns a string', (){

    final date = DateTime.parse('2016-02-29');
    const imageURL = 'FAKE_URL';
    const quantity = 100;
    const latitude = 100.1985792222;
    const longitude = 150.9999999;

    final  post = Post(date: date, imageURL: imageURL, quantity: quantity, latitude: latitude, longitude: longitude);

    expect(post.getRoundedLongitudeString(), "151.000");
  });
}