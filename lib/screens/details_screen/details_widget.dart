import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Methods/methods.dart';
import 'package:movies_app/My_theme/my_theme.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:movies_app/models/movie_detail_response.dart';
import 'package:movies_app/screens/home_screen/Home_Widget/widgets/movie_item.dart';

class DetailsWidget extends StatefulWidget {
  final Movie? movie;

  const DetailsWidget({required this.movie, super.key});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: screenSize.height * .51,
      child: FutureBuilder<MovieDetailResponse>(
        future: ApiManager.detailMoviesResponse(widget.movie?.id ?? 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: MyTheme.yellowColor),
            );
          } else if (snapshot.hasError || snapshot.data?.success == "false") {
            return Center(
                child: IconButton(
              onPressed: () {
                ApiManager.detailMoviesResponse(widget.movie?.id ?? 0);
                setState(() {});
              },
              icon: const Icon(Icons.error),
              color: MyTheme.redColor,
            ));
          }
          var movieDetails = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        MyMethods.yearFromString(widget.movie?.releaseDate),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: MyTheme.greyColor2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        movieDetails?.status?[0] ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: MyTheme.greyColor2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        MyMethods.getTimeString(movieDetails!.runtime ?? 0),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: MyTheme.greyColor2),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                height: screenSize.height * .025,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                              padding: const EdgeInsets.all(3),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.greyColor2),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                movieDetails.genres?[index].name ?? "",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: MyTheme.greyColor2),
                              ));
                        },
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: movieDetails.genres?.length,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieItem(
                      movie: widget.movie,
                      height: screenSize.height * .43,
                      width: screenSize.width * .4,
                      iconSize: 50,
                      tappable: false,
                      onPressedBookmarkIcon: onPressedBookmarkIcon),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          AutoSizeText(movieDetails.overview ?? "",
                              softWrap: true,
                              textAlign: TextAlign.justify,
                              maxLines: 19,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15)),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.star,
                                    color: MyTheme.yellowColor,
                                    size: 30,
                                  ),
                                ),
                                Text(
                                  MyMethods.roundDecimalNo(
                                      widget.movie?.voteAverage, 1),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  onPressedBookmarkIcon(Movie movie) {
    // loading

    // add to firestore

    // toast message
  }
}
