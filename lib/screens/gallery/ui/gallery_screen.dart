import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redscope_assignment/constant/constant.dart';
import 'package:redscope_assignment/repository/unsplash.dart';
import 'package:redscope_assignment/screens/gallery/ui/full_screen.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final UnsplashService _unsplashService =
      UnsplashService('${dotenv.env['UNSPLASH_API_KEY']}');
  // 'NJxfZpMa-m4RklhGC5WodaqvyXjxRPXp1UVIBkqR1gE');
  List<dynamic> _images = [];
  int _page = 1;
  final int _perPage = 20;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    try {
      final images = await _unsplashService.fetchImages(_page, _perPage);
      setState(() {
        _images.addAll(images);
      });
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Gallery', style: headingH2),
      ),
      body: _images.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                final image = _images[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImage(
                        imageUrl: image['urls']['regular'],
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      image['urls']['small'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
