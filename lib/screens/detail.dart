import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class DetailPage extends StatefulWidget {
  final keys;

  const DetailPage({Key? key, required this.keys}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState(keys);
}

class _DetailPageState extends State<DetailPage> {
  final keys;
  _DetailPageState(this.keys);

  String? title;
  String? desc;
  String? images;
  String? id;

  bool loading = false;
  bool isSave = false;
  bool hapus = false;

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> getData() async {
    setState(() {
      loading = true;
    });

    final databaseResep =
        FirebaseDatabase.instance.ref().child('public').child(keys);

    var judul = await databaseResep.child('judul').once();
    var deskripsi = await databaseResep.child('deskripsi').once();
    var image = await databaseResep.child('image').once();
    var user = await databaseResep.child('userId').once();


    setState(() {
      title = judul.snapshot.value.toString();
      desc = deskripsi.snapshot.value.toString();
      images = image.snapshot.value.toString();
      id =  user.snapshot.value.toString();
    });

    if(id == userId){
      hapus = true;
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> saveData() async {

    final userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseDatabase.instance.ref().child('user').child(userId).child('save').child(keys).set({
      'judul' : title,
      'deskripsi' : desc,
      'image' : images
    });

    setState(() {
      isSave = true;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    if(loading){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(title ?? "", style: TextStyle(color: Colors.black),),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.arrow_left, color: Colors.black,),
        ),
        actions: [
          InkWell(
            onTap: (){
              saveData();
            },
            child: Icon(isSave ? Icons.bookmark : Icons.bookmark_border, color: Colors.black,),
          ),
          id == userId ? InkWell(
          onTap: () async {
            await FirebaseDatabase.instance.ref().child('public').child(keys).remove();
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.trash_fill, color: Colors.black,),
          ) : Container(),
        ],
      ),
      body: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(images!),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deskripsi',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 15,
                              letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.w500,
                              height: 1),
                        ),
                        SizedBox(height: 20,),
                        Text(desc!)
                      ],
                    )
                  )
              ],
            ),
    );
  }
}
