import 'package:aplikasi_cookus/screens/detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MenuCookus extends StatefulWidget {
  static const routeName = "/Dashboard";
  const MenuCookus({Key? key}) : super(key: key);

  @override
  State<MenuCookus> createState() => _MenuCookusState();
}

class _MenuCookusState extends State<MenuCookus> {

  final userId = FirebaseAuth.instance.currentUser!.uid;

  final listBahan = [
    'Telor',
    'Wortel',
    'Kangkung',
    'Ayam',
    'Bayam',
    'Tomat',
    'Kentang',
    'Terong',
    'Kubis',
    'Timun'
  ];

  final listImageBahan = [
    'images/telor.png',
    'images/wortel.png',
    'images/kangkung.png',
    'images/ayam.png',
    'images/bayam.png',
    'images/tomat.png',
    'images/kentang.png',
    'images/terong.png',
    'images/kubis.png',
    'images/timun.png',
  ];

  List bahanIndex = [];

  final DatabaseReference = FirebaseDatabase.instance.ref().child('public');
  List<dynamic> _foodList = [];
  List<dynamic> resepkuList = [];
  List<dynamic> searchFoodList = [];
  String searchQuery = '';
  List<dynamic> keysResepku = [];
  List<dynamic> keys = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference.onValue.listen((event) {
      setState(() {
        _foodList.clear();
        Map<dynamic, dynamic>? _foodMap = event.snapshot.value as Map?;
        if (_foodMap != null) {
          _foodMap.entries.forEach((value) {
            keys.add(value.key);
            _foodList.add(value.value);
          });
        }
      });
    });
    DatabaseReference.orderByChild("userId").equalTo(userId).onValue.listen((event) {
      setState(() {
        resepkuList.clear();
        Map<dynamic, dynamic>? _foodMap = event.snapshot.value as Map?;
        if (_foodMap != null) {
          _foodMap.entries.forEach((value) {
            keysResepku.add(value.key);
            resepkuList.add(value.value);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _foodList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                children: [
                  Image.asset(
                    'images/logo.png',
                    scale: 2,
                    alignment: Alignment.centerLeft,
                    height: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextFormField(
                      onChanged: (value){
                        setState(() {
                          searchQuery = value;
                        });
                        setState(() {
                          searchFoodList = resepkuList
                              .where((value) => value['judul']
                              .toLowerCase()
                              .contains(searchQuery?.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 227, 221, 221)),
                          ),
                          labelText: 'Cari Menu',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 164, 162, 162))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Apa isi kulkasmu?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 13,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Text(
                    'Pilih hingga 3 bahan',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontFamily: 'Inter',
                        fontSize: 10,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Container(
                    width: double.infinity,
                    height: 120,
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listBahan.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 20),
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  if (!bahanIndex.contains(index)) {
                                    bahanIndex.add(
                                        index);
                                    if (bahanIndex.length == 4) {
                                      bahanIndex.removeAt(
                                          0);
                                    }
                                  } else {
                                    bahanIndex.remove(index);
                                  }
                                });

                                List<String> selectedBahan = [];
                                bahanIndex.forEach((index) {
                                  selectedBahan.add(listBahan[index]);
                                });

                                setState(() {
                                  if(selectedBahan.isNotEmpty){
                                    searchQuery = ".";
                                    searchFoodList = _foodList
                                        .where((food) =>
                                        selectedBahan.every((bahan) => food['deskripsi'].contains(bahan.toLowerCase())))
                                        .toList();
                                  } else {
                                    searchQuery = "";
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 2),
                                decoration: BoxDecoration(
                                    color: bahanIndex.contains(index)
                                        ? Color.fromRGBO(255, 136, 136, 2)
                                        : Color.fromRGBO(
                                            255, 136, 136, 0.20000000298023224),
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(255, 136, 136, 1))),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 13,
                                        height: 13,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  listImageBahan[index]),
                                              fit: BoxFit.fitWidth),
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(13, 13)),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      listBahan[index],
                                      style: TextStyle(fontSize: 9.5),
                                    )
                                  ],
                                ),
                              ));
                        }),
                  ),

                 // SEARCH LOGIC
                 searchQuery != ""
                  ? Container(
                   width: double.infinity,
                   child: Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Hasil Pencarian',
                           textAlign: TextAlign.left,
                           style: TextStyle(
                               color: Color.fromRGBO(0, 0, 0, 1),
                               fontFamily: 'Inter',
                               fontSize: 13,
                               letterSpacing:
                               0 /*percentages not used in flutter. defaulting to zero*/,
                               fontWeight: FontWeight.normal,
                               height: 1),
                         ),
                         Container(
                           width: double.infinity,
                           height: MediaQuery.of(context).size.height,
                           child: GridView.builder(
                               physics: NeverScrollableScrollPhysics(),
                               padding: EdgeInsets.symmetric(vertical: 10),
                               itemCount: searchFoodList.length,
                               gridDelegate:
                               SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount: 2,
                                 crossAxisSpacing: 15,
                                 mainAxisSpacing: 20,
                                 mainAxisExtent: 110,
                               ),
                               itemBuilder: (context, index) {
                                 return Container(
                                   padding: EdgeInsets.symmetric(
                                       horizontal: 10, vertical: 10),
                                   alignment: Alignment.bottomLeft,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(7),
                                     boxShadow: [
                                       BoxShadow(
                                           color: Color.fromRGBO(0, 0, 0, 0.25),
                                           offset: Offset(0, 4),
                                           blurRadius: 4)
                                     ],
                                     image: DecorationImage(
                                         image: NetworkImage(searchFoodList[index]['image']),
                                         fit: BoxFit.fill),
                                   ),
                                   child: Text(
                                     searchFoodList[index]['judul'],
                                     textAlign: TextAlign.left,
                                     style: TextStyle(
                                         color: Color.fromRGBO(255, 255, 255, 1),
                                         fontFamily: 'Inter',
                                         fontSize: 15,
                                         letterSpacing:
                                         0 /*percentages not used in flutter. defaulting to zero*/,
                                         fontWeight: FontWeight.normal,
                                         height: 1),
                                   ),
                                 );
                               }),
                         ),
                       ],
                     ),
                   ),
                 )
                  : Container(
                   width: double.infinity,
                   child: Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Rekomendasi Untukmu',
                           textAlign: TextAlign.left,
                           style: TextStyle(
                               color: Color.fromRGBO(0, 0, 0, 1),
                               fontFamily: 'Inter',
                               fontSize: 13,
                               letterSpacing:
                               0 /*percentages not used in flutter. defaulting to zero*/,
                               fontWeight: FontWeight.normal,
                               height: 1),
                         ),
                         SizedBox(
                             height: 150,
                             child: GridView.builder(
                                 physics: NeverScrollableScrollPhysics(),
                                 padding: EdgeInsets.symmetric(vertical: 10),
                                 itemCount: 2,
                                 gridDelegate:
                                 SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 2,
                                   crossAxisSpacing: 15,
                                   mainAxisSpacing: 20,
                                   mainAxisExtent: 110,
                                 ),
                                 itemBuilder: (context, index) {
                                   return InkWell(
                                     onTap: (){
                                       Navigator.push(
                                           context, MaterialPageRoute(builder: (context) => DetailPage(keys: keys[index]))
                                       );
                                     },
                                     child: Container(
                                       padding: EdgeInsets.symmetric(
                                           horizontal: 10, vertical: 10),
                                       alignment: Alignment.bottomLeft,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(7),
                                         boxShadow: [
                                           BoxShadow(
                                               color: Color.fromRGBO(0, 0, 0, 0.25),
                                               offset: Offset(0, 4),
                                               blurRadius: 4)
                                         ],
                                         image: DecorationImage(
                                             image: NetworkImage(_foodList[index]['image']),
                                             fit: BoxFit.fill),
                                       ),
                                       child: Text(
                                         _foodList[index]['judul'],
                                         textAlign: TextAlign.left,
                                         style: TextStyle(
                                             color: Color.fromRGBO(255, 255, 255, 1),
                                             fontFamily: 'Inter',
                                             fontSize: 15,
                                             letterSpacing:
                                             0 /*percentages not used in flutter. defaulting to zero*/,
                                             fontWeight: FontWeight.normal,
                                             height: 1),
                                       ),
                                     ),
                                   );
                                 }),),
                         SizedBox(height: 20,),
                         Text(
                           'Resepku',
                           textAlign: TextAlign.left,
                           style: TextStyle(
                               color: Color.fromRGBO(0, 0, 0, 1),
                               fontFamily: 'Inter',
                               fontSize: 13,
                               letterSpacing:
                               0 /*percentages not used in flutter. defaulting to zero*/,
                               fontWeight: FontWeight.normal,
                               height: 1),
                         ),

                         Container(
                           width: double.infinity,
                           height: 150,
                           child: GridView.builder(
                               scrollDirection: Axis.horizontal,
                               padding: EdgeInsets.symmetric(vertical: 20),
                               itemCount: resepkuList.length,
                               gridDelegate:
                               SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount: 1,
                                 crossAxisSpacing: 15,
                                 mainAxisSpacing: 20,
                                 mainAxisExtent: 170,
                               ),
                               itemBuilder: (context, index) {
                                 return InkWell(
                                   onTap: (){
                                     Navigator.push(
                                         context, MaterialPageRoute(builder: (context) => DetailPage(keys: keysResepku[index]))
                                     );
                                   },
                                   child: Container(
                                     padding: EdgeInsets.symmetric(
                                         horizontal: 10, vertical: 10),
                                     alignment: Alignment.bottomLeft,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(7),
                                       boxShadow: [
                                         BoxShadow(
                                             color: Color.fromRGBO(0, 0, 0, 0.25),
                                             offset: Offset(0, 4),
                                             blurRadius: 4)
                                       ],
                                       image: DecorationImage(
                                           image: NetworkImage(resepkuList[index]['image']),
                                           fit: BoxFit.fill),
                                     ),
                                     child: Text(
                                       resepkuList[index]['judul'],
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           color: Color.fromRGBO(255, 255, 255, 1),
                                           fontFamily: 'Inter',
                                           fontSize: 15,
                                           letterSpacing:
                                           0 /*percentages not used in flutter. defaulting to zero*/,
                                           fontWeight: FontWeight.normal,
                                           height: 1),
                                     ),
                                   ),
                                 );
                               }),
                         ),
                         SizedBox(height: 20,),
                         Text(
                           'Lainnya',
                           textAlign: TextAlign.left,
                           style: TextStyle(
                               color: Color.fromRGBO(0, 0, 0, 1),
                               fontFamily: 'Inter',
                               fontSize: 13,
                               letterSpacing:
                               0 /*percentages not used in flutter. defaulting to zero*/,
                               fontWeight: FontWeight.normal,
                               height: 1),
                         ),
                         SizedBox(
                             height: ((_foodList.length - 1) * 110) + 30,
                             child: GridView.builder(
                                 physics: NeverScrollableScrollPhysics(),
                                 padding: EdgeInsets.symmetric(vertical: 10),
                                 itemCount: _foodList.length,
                                 gridDelegate:
                                 SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 2,
                                   crossAxisSpacing: 15,
                                   mainAxisSpacing: 20,
                                   mainAxisExtent: 110,
                                 ),
                                 itemBuilder: (context, index) {
                                   return InkWell(
                                     onTap: () {
                                       Navigator.push(
                                           context, MaterialPageRoute(builder: (context) => DetailPage(keys: keys[index]))
                                       );
                                     },
                                     child: Container(
                                       padding: EdgeInsets.symmetric(
                                           horizontal: 10, vertical: 10),
                                       alignment: Alignment.bottomLeft,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(7),
                                         boxShadow: [
                                           BoxShadow(
                                               color: Color.fromRGBO(0, 0, 0, 0.25),
                                               offset: Offset(0, 4),
                                               blurRadius: 4)
                                         ],
                                         image: DecorationImage(
                                             image:
                                             NetworkImage(_foodList[index]['image']),
                                             fit: BoxFit.fill),
                                       ),
                                       child: Text(
                                         _foodList[index]['judul'],
                                         textAlign: TextAlign.left,
                                         style: TextStyle(
                                             color: Color.fromRGBO(255, 255, 255, 1),
                                             fontFamily: 'Inter',
                                             fontSize: 15,
                                             letterSpacing:
                                             0 /*percentages not used in flutter. defaulting to zero*/,
                                             fontWeight: FontWeight.normal,
                                             height: 1),
                                       ),
                                     ),
                                   );
                                 })),
                       ],
                     ),
                   ),
                 )
                ],
              ));
  }
}
