class MovieModel {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  MovieModel({this.page, this.results, this.totalPages, this.totalResults});

  MovieModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class Results {
  String? releaseDate;
  String? title;
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? posterPath;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? overview;
  double? popularity;
  String? mediaType;
  String? originalName;
  List<String>? originCountry;
  String? name;
  String? firstAirDate;

  Results(
      {this.releaseDate,
      this.title,
      this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.posterPath,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.overview,
      this.popularity,
      this.mediaType,
      this.originalName,
      this.originCountry,
      this.name,
      this.firstAirDate});

  Results.fromJson(Map<String, dynamic> json) {
    releaseDate = json['release_date'] ?? '';
    title = json['title'] ?? '';

    backdropPath = json['backdrop_path'];
    // genreIds = json['genre_ids'].cast<int>();
    id = json['id'] ?? 0;
    originalLanguage = json['original_language'] ?? '';
    originalTitle = json['original_title'] ?? "";
    posterPath = json['poster_path'] ?? "";

    // voteAverage = json['vote_average'] ?? 0;
    voteCount = json['vote_count'] ?? 0;
    overview = json['overview'] ?? 0;
    popularity = json['popularity'] ?? 0;
    mediaType = json['media_type'] ?? "";
    originalName = json['original_name'] ?? "";
    //originCountry = json['origin_country'].cast<String>();
    name = json['name'] ?? "";
    firstAirDate = json['first_air_date'] ?? "";
  }
}
