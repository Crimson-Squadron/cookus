import 'package:aplikasi_cookus/screens/MakeRec1Screen.dart';
import 'package:aplikasi_cookus/menu/profile_view.dart';
import 'package:aplikasi_cookus/screens/detail.dart';
import 'package:aplikasi_cookus/screens/edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyRecipeScreen extends StatefulWidget {
  const MyRecipeScreen({super.key});
  @override
  State<MyRecipeScreen> createState() => _MyRecipeScreen();
}

class _MyRecipeScreen extends State<MyRecipeScreen> {

  final DatabaseReference = FirebaseDatabase.instance.ref().child('public');
  final userId = FirebaseAuth.instance.currentUser!.uid;
  List<dynamic> resepkuList = [];
  List<dynamic> keys = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference.orderByChild('userId').equalTo(userId).onValue.listen((event) {
      setState(() {
        resepkuList.clear();
        Map<dynamic, dynamic>? _foodMap = event.snapshot.value as Map?;
        if (_foodMap != null) {
          _foodMap.entries.forEach((value) {
            keys.add(value.key);
            resepkuList.add(value.value);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 50,
          //centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-30.0, 0.0, 0.0),
            child: const Text(
              'Resep Saya',
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
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: GridView.builder(
                  itemCount: resepkuList.length,
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
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                resepkuList[index]['image'],
                              ).image,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        resepkuList[index]['judul'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(105, 6, 1, 0),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditResep(keys: keys[index])));
                                  },
                                  child: Icon(
                                    Icons.edit_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                },
                ),
              ),
            ),
          ],
        ));
  }
}
