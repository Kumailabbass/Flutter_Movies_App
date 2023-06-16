import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch:
              createMaterialColor(const Color.fromRGBO(24, 13, 29, 1)),
        ).copyWith(
          secondary: const Color.fromRGBO(232, 226, 226, 1),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(
            164, 164, 164, 1), // Set the background color to black
      ),
      home: HomeScreen(),
      routes: {
        MoviePreviewScreen.routeName: (context) => MoviePreviewScreen(),
      },
    );
  }

  // ... Rest of the code remains the same
}

MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final List<Movie> movies = [
    Movie(
      title: 'WWE',
      image: 'wwe.jpg',
      description: 'Action-packed wrestling extravaganza.',
    ),
    Movie(
      title: 'John Wick',
      image: 'john_wick.jpg',
      description:
          'John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.',
    ),
    Movie(
      title: 'Fast X',
      image: 'fast_x.jpg',
      description:
          'Dom Toretto and his family are targeted by the vengeful son of drug kingpin Hernan Reyes.',
    ),
    Movie(
      title: 'Asur',
      image: 'asur.jpg',
      description:
          'No. Forensic expert Nikhil Nair returns to the Central Bureau of Investigation (CBI) after a five-year hiatus. He is assigned to a case involving the ritualistic murders of people who have been exhumed from their graves.',
    ),
    Movie(
      title: 'Fanfic',
      image: 'fanfic.jpg',
      description:
          'Two high school students form an intense connection as they navigate the challenges of discovering and expressing their truest selves.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 26),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  CircleAvatar(
                    backgroundImage: AssetImage('lion.jpg'),
                    radius: 20.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Discover Movies',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                itemCount: movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MoviePreviewScreen.routeName,
                        arguments: movies[index],
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(movies[index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                            ),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            movies[index].title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Movie {
  final String title;
  final String image;
  final String description;

  Movie({required this.title, required this.image, required this.description});
}

// ignore: use_key_in_widget_constructors
class MoviePreviewScreen extends StatelessWidget {
  static const routeName = '/movie-preview';

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Preview'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.0, // Adjust the height as per your preference
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(movie.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Rating: 8.5',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const Text(
                    'Length: 120 mins',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    movie.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Play Movie',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
