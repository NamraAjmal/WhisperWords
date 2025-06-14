import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favorites extends StatefulWidget {
  final List<Map<String, String>> favorites;
  final Function(Map<String, String>) onRemove;
  final Function() onSave;

  const Favorites({
    super.key,
    required this.favorites,
    required this.onRemove,
    required this.onSave,
  });

  @override
  State<Favorites> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F3),
      appBar: AppBar(
        title: Text(
          'My Favorite Quotes',
          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink[100],
        elevation: 5,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
      ),
      body: widget.favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_rounded, size: 80, color: Colors.pinkAccent),
                  SizedBox(height: 20),
                  Text(
                    "No favorites yet ☁️",
                    style: GoogleFonts.quicksand(
                        fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tap the heart icon to save cozy quotes!",
                    style:
                        GoogleFonts.quicksand(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: widget.favorites.length,
              itemBuilder: (context, index) {
                final quote = widget.favorites[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade100.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    leading: const Icon(Icons.format_quote, size: 30),
                    title: Text(
                      quote['quote'] ?? '',
                      style: GoogleFonts.quicksand(fontSize: 16),
                    ),
                    subtitle: Text(
                      '- ${quote['author'] ?? "Unknown"}',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.favorites.removeAt(index);
                        });
                        widget.onRemove(quote);
                        widget.onSave();
                      },
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
