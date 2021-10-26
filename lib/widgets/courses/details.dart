import 'package:courses/models/courses.dart';
import 'package:courses/screens/courses/edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  Courses course;
  DetailPage(this.course);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  updateCourseDetails(newDetails) {
    setState(() {
      widget.course = newDetails;
    });
  }

  goToEditPage(context) {
    var user = FirebaseAuth.instance.currentUser!;

    Courses previouseCourse = Courses(
      syllabus: widget.course.syllabus,
      amount: widget.course.amount,
      totalHours: widget.course.totalHours,
      startDate: widget.course.startDate,
      description: widget.course.description,
      id: widget.course.id,
      imageURl: widget.course.imageURl,
      title: widget.course.title,
      instructorId: user.uid,
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditCourse(previouseCourse, updateCourseDetails)));
  }

  @override
  Widget build(BuildContext context) {
    final coursePrice = Container(
        padding: const EdgeInsets.all(3.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Text(
            // "\$20",
            '\$ ${widget.course.amount.toString()}',
            style: TextStyle(color: Colors.white),
          ),
        ));

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          widget.course.title!,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '${widget.course.totalHours.toString()} Hours',
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 2, child: coursePrice)
          ],
        ),
      ],
    );
    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://st2.depositphotos.com/1350793/8441/i/600/depositphotos_84416316-stock-photo-hand-pointing-to-online-course.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      widget.course.description,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () => {goToEditPage(context)},
          color: Theme.of(context).primaryColor,
          child: Text("Edit Course Data",
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }
}
