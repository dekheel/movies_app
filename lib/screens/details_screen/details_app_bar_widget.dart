import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/My_theme/my_theme.dart';
import 'package:movies_app/api/api_constatnts.dart';
import 'package:movies_app/models/general_response.dart';

class DetailsAppBar extends StatelessWidget {
  final Movie? movie;

  const DetailsAppBar({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SliverAppBar.large(
      leading: Container(
        margin: const EdgeInsets.only(top: 20, left: 20),
        width: screenSize.width * .1,
        height: screenSize.height * .02,
        decoration: BoxDecoration(
            color: MyTheme.blackColor, borderRadius: BorderRadius.circular(10)),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      expandedHeight: screenSize.height * .5,
      backgroundColor: MyTheme.blackColor,
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          child: CachedNetworkImage(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .65,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            imageUrl: "${ApiConstants.baseImageUrl}${movie?.backdropPath}",
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
        // centerTitle: true,
        title: Text(
          movie?.title ?? "",
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      pinned: true,
      floating: true,
    );
  }
}
