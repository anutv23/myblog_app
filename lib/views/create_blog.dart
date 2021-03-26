import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myblog_app/modal/data.dart';
import 'package:intl/intl.dart';

class CreateBlog extends StatefulWidget {
  final Data listdata;

  CreateBlog({this.listdata});

  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  // final f = new DateFormat('hh:mm yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "My Blogs!",
          //     style: GoogleFonts.rockSalt(
          //         fontSize: 20, color: Colors.lightBlueAccent),
          //   ),
          // ),
          backgroundColor: Colors.black,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Hero(
                  tag: widget.listdata.imagename,
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //     bottomLeft: Radius.circular(70),
                        //     bottomRight: Radius.circular(70)),
                        image: DecorationImage(
                            image: NetworkImage(widget.listdata.imagename))),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    // child: Text(
                    //   widget.title,
                    //   style: TextStyle(color: Colors.black),
                    // )
                    // child: Image.network(
                    //   widget.listdata.imagename,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 15,
                        color: Colors.red,
                      ),
                      Text(
                        widget.listdata.favname,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ]),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 18.0, left: 18, bottom: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.listdata.titlename,
                          style: GoogleFonts.chango(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        SizedBox(
                          width: 150,
                        ),

                        //  Text(f.format(DateTime.tryParse(widget.listdata.datename))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "By Kelly",
                          style: GoogleFonts.questrial(
                              color: Colors.grey, fontSize: 10),
                        ),
                        SizedBox(
                          width: 260,
                        ),
                        Icon(
                          Icons.timelapse_outlined,
                          color: Colors.grey,
                          size: 9,
                        ),
                        Text(
                          "10 secs ago",
                          style: GoogleFonts.questrial(
                              color: Colors.grey, fontSize: 9),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Card(
                      elevation: 15,
                      color: Colors.white,
                      shadowColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Center(
                          child: Text(
                            widget.listdata.decriptionname,
                            style: GoogleFonts.indieFlower(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
        // body: ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: widget.listdata.length,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       child: Column(
        //         children: [
        //           SizedBox(
        //             height: 30,
        //           ),
        //           Hero(
        //             tag: widget.listdata[index].imagename,
        //             child: Container(
        //               margin: EdgeInsets.symmetric(horizontal: 30),
        //               decoration:
        //                   BoxDecoration(borderRadius: BorderRadius.circular(6)),
        //               height: 150,
        //               width: MediaQuery.of(context).size.width - 25,
        //               // child: Text(
        //               //   widget.title,
        //               //   style: TextStyle(color: Colors.black),
        //               // ),
        //               child: Image.network(
        //                 widget.listdata[index].imagename,
        //                 fit: BoxFit.contain,
        //               ),
        //             ),
        //           ),
        //           SizedBox(
        //             height: 40,
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(14.0),
        //             child: Material(
        //               elevation: 3,
        //               color: Colors.lightBlue.shade50,
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Text(
        //                       widget.listdata[index].titlename,
        //                       style: TextStyle(
        //                           fontSize: 20, fontWeight: FontWeight.bold),
        //                     ),
        //                   ),
        //                   Divider(
        //                     color: Colors.black,
        //                     thickness: 1,
        //                     indent: 54,
        //                     endIndent: 54,
        //                   ),
        //                   SizedBox(
        //                     height: 15,
        //                   ),
        //                   Text(
        //                     widget.listdata[index].decriptionname,
        //                     style: TextStyle(
        //                         fontSize: 15, fontStyle: FontStyle.italic),
        //                   ),
        //                   Padding(padding: EdgeInsets.all(10)),
        //                 ],
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
