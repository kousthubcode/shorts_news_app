import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class news_description extends StatelessWidget {
  news_description(
      {required this.description, this.author, this.title, this.img});
  dynamic description;
  dynamic author;
  dynamic title;
  dynamic img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('News Description'),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: Container(
        height: 700,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1533035353720-f1c6a75cd8ab?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white60,
                border: Border.all(
                  width: 3,
                  color: Colors.black,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        img,
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  Text('\n'),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Times New Roman',
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(''),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "- " + author,
                              style: TextStyle(
                                  fontSize: 28,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('\n\n'),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Times New Roman',
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic news_search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: Container(
        height: 700,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1533035353720-f1c6a75cd8ab?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text('\n'),
              ),
              FutureBuilder(
                  future: apicall(news_search.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 264,
                                    height: 60,
                                    child: TextField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      onChanged: (text) => {},
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                      controller: news_search,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          borderSide: BorderSide(
                                              width: 2, color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          borderSide: BorderSide(
                                              width: 2, color: Colors.white),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Colors.white70,
                                        ),
                                        hintText: 'Enter a keyword',
                                        hintStyle:
                                            TextStyle(color: Colors.white70),
                                        filled: true,
                                        fillColor: Colors.red[900],
                                      ),
                                    ),
                                  ),
                                  Text('    '),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        future:
                                        apicall(news_search.text);
                                      });
                                    },
                                    child: const Text(
                                      'Search',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[900],
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      padding: EdgeInsets.all(20.0),
                                    ),
                                  ),
                                ],
                              ),
                              Text('\n'),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          SingleChildScrollView(
                                            child: Container(
                                              padding: EdgeInsets.all(15.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white60,
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                news_description(
                                                                  description: snapshot
                                                                          .data[
                                                                      'description$index'],
                                                                  author: snapshot
                                                                          .data[
                                                                      'author$index'],
                                                                  title: snapshot
                                                                          .data[
                                                                      'title$index'],
                                                                  img: snapshot
                                                                          .data[
                                                                      'img$index'],
                                                                )),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        child: Image.network(
                                                          snapshot.data[
                                                              'img$index'],
                                                          height: 200,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Text(''),
                                                  Text(
                                                    snapshot
                                                        .data['title$index'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'Times New Roman'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Future apicall(String news_search) async {
  if (news_search == '') {
    news_search = 'tesla';
  }

  dynamic url = Uri.parse("https://newsapi.org/v2/everything?q=" +
      news_search +
      "&from=2022-10-18&sortBy=relevancy&apiKey=424e45415f414dcd942be477524a4b41&language=en");

  final response = await http.get(url);
  print(response.body);
  final json = jsonDecode(response.body);
  print(json['status']);

  final output = {
    'author0': json['articles'][0]['author'],
    'author1': json['articles'][1]['author'],
    'author2': json['articles'][2]['author'],
    'author3': json['articles'][3]['author'],
    'author4': json['articles'][4]['author'],
    'author5': json['articles'][5]['author'],
    'author6': json['articles'][6]['author'],
    'author7': json['articles'][7]['author'],
    'author8': json['articles'][8]['author'],
    'author9': json['articles'][9]['author'],
    'title0': json['articles'][0]['title'],
    'title1': json['articles'][1]['title'],
    'title2': json['articles'][2]['title'],
    'title3': json['articles'][3]['title'],
    'title4': json['articles'][4]['title'],
    'title5': json['articles'][5]['title'],
    'title6': json['articles'][6]['title'],
    'title7': json['articles'][7]['title'],
    'title8': json['articles'][8]['title'],
    'title9': json['articles'][9]['title'],
    'description0': json['articles'][0]['description'],
    'description1': json['articles'][1]['description'],
    'description2': json['articles'][2]['description'],
    'description3': json['articles'][3]['description'],
    'description4': json['articles'][4]['description'],
    'description5': json['articles'][5]['description'],
    'description6': json['articles'][6]['description'],
    'description7': json['articles'][7]['description'],
    'description8': json['articles'][8]['description'],
    'description9': json['articles'][9]['description'],
    'img0': json['articles'][0]['urlToImage'],
    'img1': json['articles'][1]['urlToImage'],
    'img2': json['articles'][2]['urlToImage'],
    'img3': json['articles'][3]['urlToImage'],
    'img4': json['articles'][4]['urlToImage'],
    'img5': json['articles'][5]['urlToImage'],
    'img6': json['articles'][6]['urlToImage'],
    'img7': json['articles'][7]['urlToImage'],
    'img8': json['articles'][8]['urlToImage'],
    'img9': json['articles'][9]['urlToImage'],
  };
  return output;
}
