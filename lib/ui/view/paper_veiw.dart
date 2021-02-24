import 'package:flutter/material.dart';

import '../../core/models/past_papers.dart';
import '../shared/ui_helper.dart';

class PapersView extends StatefulWidget {
  final Modules module;

  const PapersView({Key key, this.module}) : super(key: key);
  @override
  _PapersViewState createState() => _PapersViewState();
}

class _PapersViewState extends State<PapersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          children: [
            ClipPath(
              //upper clippath with less height
              clipper: WaveClipper(), //set our custom wave clipper.
              child: Container(
                padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                color: Theme.of(context).primaryColor,
                height: 240,
                alignment: Alignment.center,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UIHelper.verticalSpaceSmall(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 12.0),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headline2,
                        text: "${widget.module.name}",
                      ),
                    ),
                    /*
                    Text(
                      "${widget.module.name}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    */
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              height: MediaQuery.of(context).size.height,
              child: ListView(
                primary: false,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: getSemester(widget.module),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getSemester(Modules module) => ListView.builder(
        itemCount: module.papers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('PdfView', arguments: module.papers[index]);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: Text(
                  "${module.papers[index].year}",
                  style: Theme.of(context).textTheme.headline2,
                ),
                title: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 12.0),
                  maxLines: 2,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline5,
                    text: module.papers[index].name,
                  ),
                ),
              ),
            ),
          );
        },
      );
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
