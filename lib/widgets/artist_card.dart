import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';
import 'package:spotifyapp/widgets/start.dart';

class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard({@required this.artist});

  Widget _buildDetailCard(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black], // whitish to gray
                tileMode: TileMode.clamp,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.artist.name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Muli',
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
                overflow: TextOverflow.clip,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: StarDisplay(
                    value: ((this.artist.popularity / 100) * 5).round()),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.people, color: Colors.white),
                  ),
                  Text(
                    "${this.artist.followers}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Muli',
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl:
            this.artist.images.isNotEmpty ? this.artist.images.first.url : "",
        filterQuality: FilterQuality.medium,
        imageBuilder: (context, ImageProvider imageProvider) => Container(
              margin: EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.50),
                      offset: Offset(10, 20),
                      blurRadius: 15)
                ],
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
              child: _buildDetailCard(context),
            ));
  }
}
