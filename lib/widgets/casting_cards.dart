import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int id;

  const CastingCards({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(id),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {

        if(!snapshot.hasData){
          return const SizedBox(
            height: 200,
            child: CupertinoActivityIndicator(),
          );
        }

        final cast = snapshot.data;

        return Container(
          width: double.infinity,
          height: 200,
          color: Colors.white,
          margin: const EdgeInsets.only(top: 10, bottom: 60),
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _CastCard(),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Star Wars asdasd asdasda sdasdas dafasf asfasda fsafasfasf asfasf ',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
