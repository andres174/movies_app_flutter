import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // todo Card Swiper
            CardSwiper(
              movies: moviesProvider.onDisplayMovies
            ),
        
            // todo Listado horizontal de peliculas 
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () {
                moviesProvider.getPopularMovies();
              },
            ),
          ],
        ),
      ),
    );
  }
}