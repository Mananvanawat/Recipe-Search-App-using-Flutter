import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
class NewClass extends StatefulWidget {
  final x;

  NewClass(this.x);

  @override
  _NewClassState createState() => _NewClassState();
}

class _NewClassState extends State<NewClass> {
  var bcs;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Details',
              style: GoogleFonts.acme(fontSize: 25, color: Colors.black)),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    widget.x['label'],
                    style: GoogleFonts.aBeeZee(fontSize: 25),
                  ),
                ),
              ),
              /**/
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)),
                          child: Container(
                            color: Colors.cyan,
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.24,
                              child: Hero(
                                  tag: widget.x['image'],
                                  child: Image.network(widget.x['image']))),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.57,
                          width: MediaQuery.of(context).size.width,

                          child: Padding(
                            padding: const EdgeInsets.all(22),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Ingredients : ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(

                                      itemCount: widget.x['ingredientLines'].length,
                                      itemBuilder: (context, index) {
                                        return Text((index+1).toString()+'. '+
                                            widget.x['ingredientLines'][index],
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20));
                                      }),
                                ),


                        InkWell(
                        child: Text("CLICK HERE TO SEE COMPLETE RECIPE",style: GoogleFonts.abel(fontSize: 17,color: Colors.black),),
                        onTap: () async {
                          print('taped');
                          if (await canLaunch(widget.x['url'])) {
                            await launch(widget.x['url']);
                          }
                        },
                      )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
