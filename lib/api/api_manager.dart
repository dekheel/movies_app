import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/api/api_constatnts.dart';
import 'package:movies_app/models/category_response.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:movies_app/models/movie_detail_response.dart';

class ApiManager {
  // get categories from api
  static Future<CategoryResponse> getCategoryResponse() async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.categoriesApi, {
      "apiKey": ApiConstants.apiKey,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return CategoryResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get popular movies from api
  static Future<GeneralResponse> getPopularMoviesResponse(String pageNo) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.popularMovieApi,
        {"apiKey": ApiConstants.apiKey, "language": "en-US", "page": pageNo});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get upComing movies from api
  static Future<GeneralResponse> getUpComingMoviesResponse(
      String pageNo) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.upComingMovieApi,
        {"apiKey": ApiConstants.apiKey, "language": "en-US", "page": pageNo});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get top rated movies from api
  static Future<GeneralResponse> getTopRatedMoviesResponse(
      String pageNo) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.topRatedMovieApi,
        {"apiKey": ApiConstants.apiKey, "language": "en-US", "page": pageNo});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get detail movie from api
  static Future<MovieDetailResponse> detailMoviesResponse(
      String movie_id) async {
    Uri url =
        Uri.https(ApiConstants.baseurl, ApiConstants.detailMovieApi(movie_id), {
      "apiKey": ApiConstants.apiKey,
      "language": "en-US",
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MovieDetailResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get similar movies from api
  static Future<GeneralResponse> getSimilarMoviesResponse(
      String movie_id, String pageNo) async {
    Uri url = Uri.https(
        ApiConstants.baseurl,
        ApiConstants.similarMovieApi(movie_id),
        {"apiKey": ApiConstants.apiKey, "language": "en-US", "page": pageNo});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // search movies from api
  static Future<GeneralResponse> searchMovieResponse(String movieTitle) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.searchMovieApi,
        {"apiKey": ApiConstants.apiKey, "query": movieTitle});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // search movies from api
  static Future<GeneralResponse> discoverMovieByCategoryResponse(
      String pageNo, String categoryId) async {
    Uri url = Uri.https(
        ApiConstants.baseurl, ApiConstants.discoverMoviesByCategoryApi, {
      "apiKey": ApiConstants.apiKey,
      "page": pageNo,
      "with_genres": categoryId,
      "sort_by": "popularity.desc",
      "language": "en-US"
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
