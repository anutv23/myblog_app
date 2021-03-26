import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Data {
  String titlename;
  String decriptionname;
  String imagename;
  String favname;

  Data({this.titlename, this.decriptionname, this.imagename, this.favname});

  Data.fromJson(Map<String, dynamic> json) {
    titlename = json['title'];
    decriptionname = json['description'];
    imagename = json['image'];
    favname = json['likes'];
    // datename = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.titlename;
    data['description'] = this.decriptionname;
    data['image'] = this.imagename;
    data['likes'] = this.favname;
    //data['date'] = this.datename;
  }
}
