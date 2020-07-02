import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'showPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var searchedRecipe = "Banana";

  Future getData(String query1) async {
    final query = query1;
    final key = 'c8ea8a90bc57d8f4368f05e0d2c98577';
    var response = await http.get(
        'https://api.edamam.com/search?q=$query&app_id=91730289&app_key=$key');
    var data1 = jsonDecode(response.body);
    print(data1['hits'][0]);
    return data1;
  }

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'RECIPES',
            style: GoogleFonts.passionOne(color: Colors.black,fontSize: 30),
          ),
          elevation: 0,
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          child: Container(
            color: Colors.cyan,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: Colors.white,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  setState(() {
                                    searchedRecipe = searchedRecipe;
                                  });
                                }),
                            hintText: "Search",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onSubmitted: (data) {
                          setState(() {
                            searchedRecipe = data;
                          });
                        },
                        onChanged: (data) {
                          searchedRecipe = data;
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getData(searchedRecipe),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        var snapData = snapshot.data;
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                            itemCount: snapData['hits'].length > 10
                                ? 10
                                : snapData['hits'].length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewClass(
                                              snapData['hits'][index]
                                                  ['recipe'])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      height: 116,
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    snapData['hits'][index]
                                                        ['recipe']['label'],
                                                    style: GoogleFonts.pacifico(
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    'Source: ' +
                                                        snapData['hits'][index]
                                                                ['recipe']
                                                            ['source'],
                                                    style: GoogleFonts.indieFlower(
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Container(
                                                    height: 100,
                                                    child: Hero(
                                                      tag: snapData['hits']
                                                              [index]['recipe']
                                                          ['image'],
                                                      child: Image.network(
                                                          snapData['hits']
                                                                      [index]
                                                                  ['recipe']
                                                              ['image']),
                                                    ))),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
