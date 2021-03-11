import "dart:io";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:location/location.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget{

  @override
  HomePageState createState () => HomePageState();
}

class HomePageState extends State<HomePage>{

  LocationData locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }
  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  File image;
  final picker = ImagePicker();

  Future getImage() async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    setState(() {});

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(Path.basename(image.path));
    UploadTask uploadTask = ref.putFile(image);

    uploadTask.then( (res) async {
      final imageURL = await res.ref.getDownloadURL();
      print(imageURL);
    });


    setState(() {});

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("MyApp"), centerTitle: true,),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData || locationData == null) return const Text('loading...');
          return Column(
            children: [
              Expanded(child: Text('Latitude: ${locationData.latitude}')),
              Expanded( child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, index) {
              String name = snapshot.data.docs[index]['name'];
              int count = snapshot.data.docs[index]['count'];
              DateTime date = snapshot.data.docs[index]['date'].toDate();
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name),
                    Text(count.toString())                  
                  ]
                ),
                subtitle: Text(date.toString()),
                onTap: () => {
                  FirebaseFirestore.instance.runTransaction( (transaction) async {
                    DocumentSnapshot freshSnap = await transaction.get(snapshot.data.docs[index].reference);
                    transaction.update(freshSnap.reference, {'count': freshSnap['count'] + 1});
                  })
                });
              },
            )),
            ElevatedButton(
              child: Text("Select Photo"),
              onPressed: (){
                getImage();
              }
            )
            ]);
            }
          ),
          
    );
  }

}

