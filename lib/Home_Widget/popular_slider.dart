import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/My_theme/my_theme.dart';
import 'package:movies_app/api/api_constatnts.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/general_response.dart';

class PopularSlider extends StatefulWidget {
  const PopularSlider({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  State<PopularSlider> createState() => _PopularSliderState();
}

class _PopularSliderState extends State<PopularSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.screenSize.height * .35,
      child: FutureBuilder<GeneralResponse>(
          future: ApiManager.getPopularMoviesResponse("1"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: MyTheme.yellowColor),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Something went wrong!",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ApiManager.getPopularMoviesResponse("1");
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: Text(
                        "Try again",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.data?.success == "false") {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.data?.statusMessage ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ApiManager.getPopularMoviesResponse("1");
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: Text(
                        "Try again",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
              );
            }

            var results = snapshot.data?.results;

            // List<Movie>? movies = snapshot.data?.results;
            return CarouselSlider.builder(
                itemCount: results?.length,
                itemBuilder: (context, index, realIndex) {
                  return SizedBox(
                    height: widget.screenSize.height * .35,
                    width: widget.screenSize.width * .70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        fit: BoxFit.fill,
                        imageUrl:
                            "${ApiConstants.baseImageUrl}${results?[index].posterPath}",
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
                  );
                },
                options: CarouselOptions(
                    autoPlay: true,
                    height: widget.screenSize.height * .35,
                    enlargeCenterPage: true,
                    pageSnapping: true,
                    viewportFraction: 0.55,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(seconds: 1)));
          }),
    );
  }
}
