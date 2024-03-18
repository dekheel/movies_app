import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/My_theme/my_theme.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:movies_app/screens/home_screen/Home_Widget/widgets/movie_item.dart';

class PopularSlider extends StatefulWidget {
  const PopularSlider({
    super.key,
  });

  @override
  State<PopularSlider> createState() => _PopularSliderState();
}

class _PopularSliderState extends State<PopularSlider> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: screenSize.height * .35,
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
                  return MovieItem(
                    iconSize: 70,
                    height: screenSize.height * .65,
                    width: screenSize.width * .70,
                    movie: results?[index],
                    onPressedBookmarkIcon: onPressedBookmarkIcon,
                  );
                },
                options: CarouselOptions(
                    autoPlay: true,
                    height: screenSize.height * .35,
                    enlargeCenterPage: true,
                    pageSnapping: true,
                    viewportFraction: 0.55,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(seconds: 1)));
          }),
    );
  }

  onPressedBookmarkIcon(Movie movie) {
    // loading

    // add to firestore

    // toast message
  }
}
