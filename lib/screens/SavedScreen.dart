import 'package:aplikasi_cookus/menu/profile_view.dart';
import 'package:aplikasi_cookus/screens/detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});
  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {

  final userId = FirebaseAuth.instance.currentUser!.uid;

  var DatabaseReference = FirebaseDatabase.instance.ref().child('user');
  List<dynamic> saveList = [];
  List<dynamic> keys = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference = FirebaseDatabase.instance.ref().child('user').child(userId).child('save');

    DatabaseReference.onValue.listen((event) {
      setState(() {
        saveList.clear();
        Map<dynamic, dynamic>? _foodMap = event.snapshot.value as Map?;
        if (_foodMap != null) {
          _foodMap.entries.forEach((value) {
            keys.add(value.key);
            saveList.add(value.value);
          });
        }
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 50,
          //centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-30.0, 0.0, 0.0),
            child: const Text(
              'Tersimpan',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          leading: Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_rounded,
                    color: Colors.black,
                    size: 25,
                  )),
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: GridView.builder(
                    itemCount: saveList.length,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1,
                    ), itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(keys: keys[index])));
                        },
                        child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 116,
                                  height: 116,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.network(
                                        saveList[index]['image'],
                                      ).image,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Text(
                                  saveList[index]['judul'],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                        ),
                      );
                  },

                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
