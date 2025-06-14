// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:quotes/favorites.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: homePage(),
//     );
//   }
// }

// class homePage extends StatefulWidget {
//   const homePage({super.key});

//   @override
//   State<homePage> createState() => _homePageState();
// }

// class _homePageState extends State<homePage> {
//   String quote = "Loading...";
//   String author = "Loading...";
//   bool isFavorite = true;
//   List<Map<String, String>> favoriteQuotes = [];
//   void removeFromFavorites(Map<String, String> quote) {
//     setState(() {
//       favoriteQuotes.removeWhere((item) =>
//           item['quote'] == quote['quote'] && item['author'] == quote['author']);
//     });
//   }

//   void saveFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String jsonFav = jsonEncode(favoriteQuotes);
//     await prefs.setString('favorites', jsonFav);
//   }

//   void loadFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? jsonFavorites = prefs.getString('favorites');
//     if (jsonFavorites != null) {
//       setState(() {
//         favoriteQuotes = List<Map<String, String>>.from(
//             jsonDecode(jsonFavorites)
//                 .map((item) => Map<String, String>.from(item)));
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadFavorites();
//     fetchQuotes();
//   }

//   void fetchQuotes() async {
//     final res = await http.get(Uri.parse('https://zenquotes.io/api/random'));
//     if (res.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(res.body);
//       setState(() {
//         String newQuote = data[0]['q'];
//         String newAuthor = data[0]['a'];
//         setState(() {
//           quote = newQuote;
//           author = newAuthor;
//         });
//       });
//     } else {
//       setState(() {
//         quote = "Failed to load quote.";
//         author = "Failed to load";
//       });
//     }
//   }

//   Widget build(BuildContext context) {
//     isFavorite = favoriteQuotes
//         .any((item) => item['quote'] == quote && item['author'] == author);
//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       // appBar: AppBar(
//       //   title: Text("Quotes"),
//       //   backgroundColor: Colors.amberAccent,
//       // ),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               child: Column(
//                 children: [
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Container(
//                         width: 300,
//                         height: 300,
//                         decoration: BoxDecoration(
//                             // border: Border.all(
//                             //   color: Colors.blueGrey.shade100,
//                             //   width: 0,
//                             // ),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15))),
//                         alignment: Alignment.center,
//                         child: Text(
//                           '"$quote"',
//                           style: TextStyle(fontSize: 25),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Container(
//                       alignment: Alignment.center,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 11.0),
//                         child: Text(
//                           author,
//                           style: TextStyle(
//                               fontStyle: FontStyle.italic, fontSize: 17),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 30.0),
//                         child: IconButton(
//                           onPressed: () {
//                             if (quote == "Failed to load quote." ||
//                                 author == "Failed to load") {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(SnackBar(
//                                       content: Center(
//                                 child: Text(
//                                     "Can't favorite a failed quote. Try Refreshing!"),
//                               )));
//                               return;
//                             }
//                             setState(() {
//                               isFavorite = !isFavorite;
//                               if (isFavorite) {
//                                 favoriteQuotes.add({
//                                   'quote': quote,
//                                   'author': author,
//                                 });
//                                 saveFavorites();
//                               } else {
//                                 favoriteQuotes.removeWhere((item) =>
//                                     item['quote'] == quote &&
//                                     item['author'] == author);
//                                 saveFavorites();
//                               }
//                             });
//                           },
//                           icon: Icon(isFavorite
//                               ? Icons.favorite
//                               : Icons.favorite_border),
//                           color: Colors.red,
//                           iconSize: 50,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 30.0),
//                         child: IconButton(
//                           onPressed: () {
//                             fetchQuotes();
//                           },
//                           icon: Icon(Icons.refresh),
//                           color: Colors.blueGrey,
//                           iconSize: 50,
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.pink[100],
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             // IconButton(
//             //   onPressed: () {},
//             //   icon: Icon(Icons.home_filled),
//             //   iconSize: 50,
//             // ),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Favorites(
//                           favorites: favoriteQuotes,
//                           onRemove: removeFromFavorites,
//                           onSave: saveFavorites),
//                     ));
//               },
//               icon: Icon(Icons.star_outlined),
//               iconSize: 50,
//               color: Colors.yellow,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'favorites.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhisperWords',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        scaffoldBackgroundColor: const Color(0xFFFFF1F3),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.pink[200],
          secondary: Colors.pink[100],
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quote = "Loading...";
  String author = "Loading...";
  List<Map<String, String>> favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
    fetchQuotes();
  }

  Future<void> fetchQuotes() async {
    final res = await http.get(Uri.parse('https://zenquotes.io/api/random'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() {
        quote = data[0]['q'];
        author = data[0]['a'];
      });
    } else {
      setState(() {
        quote = "Failed to load quote.";
        author = "Unknown";
      });
    }
  }

  void saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonFav = jsonEncode(favoriteQuotes);
    await prefs.setString('favorites', jsonFav);
  }

  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonFavorites = prefs.getString('favorites');
    if (jsonFavorites != null) {
      setState(() {
        favoriteQuotes = List<Map<String, String>>.from(
          jsonDecode(jsonFavorites)
              .map((item) => Map<String, String>.from(item)),
        );
      });
    }
  }

  void removeFromFavorites(Map<String, String> quote) {
    setState(() {
      favoriteQuotes.removeWhere((item) =>
          item['quote'] == quote['quote'] && item['author'] == quote['author']);
    });
  }

  bool get isFavorite {
    return favoriteQuotes
        .any((item) => item['quote'] == quote && item['author'] == author);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        favoriteQuotes.removeWhere(
            (item) => item['quote'] == quote && item['author'] == author);
      } else {
        favoriteQuotes.add({'quote': quote, 'author': author});
      }
      saveFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF1F3), Color(0xFFFFDDEE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Column(
                children: [
                  Text(
                    "WhisperWords",
                    style: GoogleFonts.quicksand(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD87D9A),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade100,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '"$quote"',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(fontSize: 22),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '- $author',
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: toggleFavorite,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.pink,
                        ),
                        iconSize: 40,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: fetchQuotes,
                        icon: const Icon(Icons.refresh),
                        iconSize: 40,
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink[100],
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.star_outline),
                iconSize: 32,
                color: Colors.deepOrange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Favorites(
                        favorites: favoriteQuotes,
                        onRemove: removeFromFavorites,
                        onSave: saveFavorites,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
