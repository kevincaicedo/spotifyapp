import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotifyapp/domain/album/album_model.dart';

class AlbumView extends StatelessWidget {
  final Album album;
  const AlbumView({this.album});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CachedNetworkImage(
            imageUrl:
                this.album.images.isNotEmpty ? this.album.images.first.url : "",
            filterQuality: FilterQuality.medium,
            placeholder: (context, _) => Container(
                  margin:
                      EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                ),
            imageBuilder: (context, ImageProvider imageProvider) => Container(
                  margin:
                      EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.50),
                          offset: Offset(10, 20),
                          blurRadius: 15)
                    ],
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.album.name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              Text(
                this.album.releaseDate,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )
            ],
          ),
        ))
      ],
    );
  }
}
