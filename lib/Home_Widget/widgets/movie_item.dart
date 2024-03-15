import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/My_theme/my_theme.dart';
import 'package:movies_app/api/api_constatnts.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:movies_app/models/movie_detail_response.dart';

class MovieItem extends StatefulWidget {
  MovieItem(
      {super.key,
      required this.movie,
      required this.height,
      required this.width,
      required this.iconSize,
      this.withBottomDetail = false,
      required this.onPressedBookmarkIcon});

  final Movie? movie;
  Function onPressedBookmarkIcon;
  double height;
  double width;
  double iconSize;
  bool withBottomDetail;

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  Color iconColor = MyTheme.greyColor.withOpacity(.70);
  IconData? icon = Icons.add;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(5),
      height: widget.height,
      width: widget.width,
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CachedNetworkImage(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .65,
            fit: BoxFit.fill,
            imageUrl: "${ApiConstants.baseImageUrl}${widget.movie?.posterPath}",
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: MyTheme.yellowColor,
              ),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: MyTheme.redColor,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            widget.onPressedBookmarkIcon(widget.movie);
            if (icon == Icons.add) {
              icon = Icons.check;
              iconColor = MyTheme.yellowColor.withOpacity(.70);
            } else {
              icon = Icons.add;
              iconColor = MyTheme.greyColor.withOpacity(.70);
              ;
            }
            setState(() {});
          },
          child: Positioned(
              top: 0,
              left: 0,
              child: Stack(children: [
                Icon(
                  Icons.bookmark_rounded,
                  size: widget.iconSize,
                  color: iconColor,
                ),
                Positioned(
                    right: 0,
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      icon,
                      color: MyTheme.whiteColor,
                    ))
              ])),
        ),
        widget.withBottomDetail
            ? FutureBuilder<MovieDetailResponse>(
                future: ApiManager.detailMoviesResponse(widget.movie?.id ?? 0),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: MyTheme.yellowColor),
                    );
                  } else if (snapshot.hasError ||
                      snapshot.data?.success == "false") {
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

                  return Positioned(
                    bottom: 0,
                    child: Container(
                      height: widget.height * .25,
                      width: widget.width,
                      color: Theme.of(context).cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.star,
                                    color: MyTheme.yellowColor,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  roundDecimalNo(widget.movie?.voteAverage, 1),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5.0),
                            child: Text(
                              widget.movie?.originalTitle ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    yearFromString(widget.movie?.releaseDate),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    movieDetails?.status?[0] ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    getTimeString(movieDetails!.runtime ?? 0),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : const SizedBox.shrink()
      ]),
    );
  }

  String roundDecimalNo(double? number, int noOfDecimal) {
    if (number != null) {
      return number.toStringAsFixed(noOfDecimal);
    }
    return "";
  }

  String yearFromString(String? dateString) {
    if (dateString != null) {
      return DateTime.parse(dateString).year.toString();
    }
    return "";
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(1, "0")}h ${minutes.toString().padLeft(2, "0")}m';
  }
}