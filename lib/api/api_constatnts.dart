class ApiConstants {
  static const String baseurl = "api.themoviedb.org";
  static const String api_key = "3665420007bd40658a77bea4f79343f2";

  static const String categoriesApi = "/3/genre/movie/list";
  static const String popularMovieApi = "/3/movie/popular";
  static const String upComingMovieApi = "/3/movie/upcoming";
  static const String topRatedMovieApi = "/3/movie/top_rated";

  static String detailMovieApi(int movieId) {
    return "/3/movie/$movieId";
  }

  static const String searchMovieApi = "/3/search/movie";

  static String similarMovieApi(int movieId) {
    return "/3/movie/$movieId/similar";
  }

  static const String discoverMoviesByCategoryApi = "3/discover/movie";

  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
}
