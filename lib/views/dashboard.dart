import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:myblog_app/views/home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File _image;

  final imagePicker = ImagePicker();
  Future getGallery() async {
    final image = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/dash.jpg"),
                      fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 100),
            child: _image != null
                ? InkWell(
                    onTap: getGallery,
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      radius: 50,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: getGallery,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://image.shutterstock.com/image-vector/female-default-avatar-profile-icon-260nw-1725062356.jpg"),
                      radius: 40,
                    ),
                  ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 270),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lets explore \nthings",
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      //   fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    "differently!",
                    style: GoogleFonts.satisfy(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 46,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.w700,
                      //fontStyle: FontStyle.italic,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black.withOpacity(0.5)),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => HomePage()));
                          },
                          child: Text("EXPLORE",
                              style: GoogleFonts.roboto(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 10,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
