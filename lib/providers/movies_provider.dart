import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'ebdcb0263960de0880214e632c7d2682';
  final String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider(){
    /* print('Provider Inicializado'); */
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, {int page = 1} ) async {
    var url = Uri.https(
      _baseUrl,
      endPoint,
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page'
      }
    );

    final response = await http.get(url);
    return response.body;
  }

  getNowPlayingMovies() async {

    final response = await _getJsonData('/3/movie/now_playing',);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;
    final response = await _getJsonData('/3/movie/popular', page: _popularPage);
    final popularResponse = PopularResponse.fromJson(response);

    // * Se desectrustura para la paginacion
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    print('Haciendo la petición');

    final response = await _getJsonData('/3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(response);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

}