import 'dart:io';
import 'dart:ui';
import 'package:aplikasi_cookus/screens/dashboard.dart';
import 'package:aplikasi_cookus/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:aplikasi_cookus/screens/MyRecipeScreen.dart';
import 'package:aplikasi_cookus/menu/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {

  File? image;
  String? urlImage;

  var JudulController = TextEditingController();
  var DeskripsiController = TextEditingController();

  Future openGaleri() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
    });
    uploadFotoProfile();
  }

  Future uploadFotoProfile() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String fileName = basename(image!.path);
    await FirebaseStorage.instance.ref().child('resep/$userId/$fileName').putFile(image!);
    var url = await FirebaseStorage.instance.ref().child('resep/$userId/$fileName').getDownloadURL();
    setState(() {
      urlImage = url.toString();
    });
  }

  @override
  Widget build(BuildContext context) {

    Future<void> saveData() async {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      try {
        if(urlImage != null){
          await FirebaseDatabase.instance.ref().child('public').push().set({
            'judul': JudulController.text,
            'deskripsi' : DeskripsiController.text,
            'image' : urlImage,
            'userId' : userId
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Sukses menyimpan data")),
          );
          setState(() {
            JudulController.text = "";
            DeskripsiController.text = "";
            urlImage = "";
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Silahkan tambahkan image dulu")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Terjadi Kesalahan saat menyimpan data")),
        );
      }
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x33FF8888), Color(0xFFFF8888)],
          stops: [0, 1],
          begin: AlignmentDirectional(0, -1),
          end: AlignmentDirectional(0, 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8, 15, 8, 15),
        child: Material(
          color: Colors.transparent,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        Dashboard.routeName;
                      },
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(150, 0, 0, 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          openGaleri();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: IconButton(
                        icon: const Icon(
                          Icons.save,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          saveData();
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: JudulController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Judul',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                    minLines: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: DeskripsiController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Deskripsi',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 30,
                    minLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
