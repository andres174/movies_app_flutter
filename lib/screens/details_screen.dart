import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    //todo cambiar por una instancia de movie
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [
          _CustomAppbar(backDrop: movie.fullBackdropImg, name: movie.originalTitle,),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(poster: movie.fullPosterImg, title: movie.title, originalTitle: movie.originalTitle, voteAvg: movie.voteAverage,),
              _Overview(overview: movie.overview,),
              CastingCards( id: movie.id)
            ]),
          ),
        ],
      ),
    );
  }
}
  

class _CustomAppbar extends StatelessWidget {

 final String backDrop;
 final String name;

  const _CustomAppbar({required this.backDrop, required this.name});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //todo meter al theme
      backgroundColor: Colors.lime,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),  
        ), 
        titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          /* image: AssetImage('assets/loading.gif'), */
          image: NetworkImage(backDrop),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  final String poster;
  final String title;
  final String originalTitle;
  final double voteAvg;

  const _PosterAndTitle({
    required this.poster, 
    required this.title, 
    required this.originalTitle, 
    required this.voteAvg
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; 

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(poster),
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20,),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width-180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  originalTitle,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 20, color: Colors.amber,),
                    const SizedBox(width: 5,),
                    Text(voteAvg.toString(), style: Theme.of(context).textTheme.bodySmall),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {
  
  final String overview;

  const _Overview({required this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

