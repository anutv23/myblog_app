import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myblog_app/modal/data.dart';
import 'package:myblog_app/views/create_blog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = Firestore.instance.collection("myblogs");
  final caref = Firestore.instance.collection("carousel");
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  Map<String, dynamic> addToBlog;

  addData() {
    addToBlog = {
      'title': titleController.text,
      'description': descController.text,
      'image': imageController.text
    };

    ref.add(addToBlog).whenComplete(() => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My Blogs!",
            style: GoogleFonts.rockSalt(
                fontSize: 20, color: Colors.lightBlueAccent),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(75.0)),
                    color: Colors.lightBlue.shade200,
                  ),
                ),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(75.0)),
                    color: Colors.lightBlue.shade100,
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(75)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                      hintText: 'What are you reading today?',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 12),
              child: Text(
                "TOP FAVOURITES:",
                style: GoogleFonts.prata(
                    fontSize: 9, letterSpacing: 2, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: caref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return CarouselSlider(
                            items: [
                              Container(
                                margin: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot
                                        .data.documents[index].data["caro1"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot
                                        .data.documents[index].data["caro2"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot
                                        .data.documents[index].data["caro3"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                            options: CarouselOptions(
                              height: 180.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                            ),
                          );
                        });
                  } else
                    return CircularProgressIndicator();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 12),
              child: Text(
                "TOP RECOMMENDS:",
                style: GoogleFonts.prata(
                    fontSize: 9, letterSpacing: 2, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<Data> dataList = snapshot.data.documents
                      .map((e) => Data.fromJson(e.data))
                      .toList();

                  return ListView.builder(
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => CreateBlog(
                            //               listdata: dataList,
                            //             )));

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CreateBlog(
                                          listdata: dataList[index],
                                        )));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Card(
                              elevation: 15,
                              color: Colors.white,
                              shadowColor: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: dataList[index].imagename,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            dataList[index].imagename,
                                            height: 150,
                                            width: 100,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                dataList[index].titlename,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                dataList[index].decriptionname,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                softWrap: false,
                                                style: GoogleFonts.sacramento(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 20.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      titleController.text =
                                                          dataList[index]
                                                              .titlename;

                                                      descController.text =
                                                          dataList[index]
                                                              .decriptionname;

                                                      imageController.text =
                                                          dataList[index]
                                                              .imagename;

                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  Dialog(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          340,
                                                                      width:
                                                                          300,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: titleController,
                                                                              decoration: InputDecoration(
                                                                                // focusColor: Colors.black,
                                                                                labelText: 'Title',
                                                                                // hintText: 'Enter the title',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(
                                                                              horizontal: 10.0,
                                                                            ),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: descController,
                                                                              maxLines: 3,
                                                                              decoration: InputDecoration(
                                                                                // focusColor: Colors.black,
                                                                                labelText: 'Description',
                                                                                // hintText: 'What would you like to pen?',
                                                                                // hintMaxLines: 3
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: imageController,
                                                                              decoration: InputDecoration(
                                                                                // focusColor: Colors.black,
                                                                                labelText: 'Image',
                                                                                // hintText: 'Upload and image',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 18.0),
                                                                            child:
                                                                                Container(
                                                                              height: 45,
                                                                              width: 75,
                                                                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(19)),
                                                                              child: TextButton(
                                                                                onPressed: () {
                                                                                  snapshot.data.documents[index].reference.updateData({
                                                                                    "title": titleController.text,
                                                                                    "description": descController.text,
                                                                                    "image": imageController.text
                                                                                  }).whenComplete(() => Navigator.pop(context));
                                                                                },
                                                                                child: Text(
                                                                                  "Update",
                                                                                  style: TextStyle(color: Colors.black),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ));
                                                    },
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.grey,
                                                      size: 15,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      snapshot
                                                          .data
                                                          .documents[index]
                                                          .reference
                                                          .delete();
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .delete_forever_outlined,
                                                      color: Colors.grey,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          child: Container(
                            height: 400,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: TextFormField(
                                      validator: (val) => val.isEmpty
                                          ? "Title cant be empty"
                                          : null,
                                      controller: titleController,
                                      decoration: InputDecoration(
                                        // focusColor: Colors.black,
                                        labelText: 'Title',
                                        // hintText: 'Enter the title',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: TextFormField(
                                      controller: descController,
                                      maxLines: 2,
                                      validator: (val) => val.isEmpty
                                          ? "Description cant be empty"
                                          : null,
                                      decoration: InputDecoration(
                                        // focusColor: Colors.black,
                                        labelText: 'Description',
                                        // hintText: 'What would you like to pen?',
                                        // hintMaxLines: 3
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: TextFormField(
                                      controller: imageController,
                                      validator: (val) => val.isEmpty
                                          ? "Image URL cant be empty"
                                          : null,
                                      decoration: InputDecoration(
                                        // focusColor: Colors.black,
                                        labelText: 'Image',
                                        // hintText: 'Upload and image',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(19)),
                                      child: TextButton(
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            addData();
                                          }
                                        },
                                        child: Text(
                                          "Add",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

// onTap: () {
//                                 // Navigator.push(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //         builder: (_) => CreateBlog(
//                                 //               listdata: dataList,
//                                 //             )));

//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => CreateBlog(
//                                               listdata: dataList[index],
//                                             )));
//                               },
