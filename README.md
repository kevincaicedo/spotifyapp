# Spotifyapp

Spotify API consuming app Example

## App Example
![Alt text](https://raw.githubusercontent.com/kevincaicedo/spotifyapp/master/screenshots/app.gif "Title")


## Getting Started

### **Important**

You need config your Spotify Api Token in ```./lib/config/constant.dart```

```dart
class Constants {
  static const SPOTIFY_TOKEN = "(Your Token Here)";
}
```

### **Architecture**
##### Domain-Driven Design

![Alt text](https://raw.githubusercontent.com/kevincaicedo/spotifyapp/master/screenshots/architecture.png "Title")


### **Directory Structure**

```
lib
│───main.dart
│───service_locator.dart
│───config
|    │──constant.dart
|    └──route.dart
│───domain
│    │──album/
|    └──artist/
│───extension
|    └──state.dart
│───infrastructure
|    │──artist/
|    │──database/
|    └──spotify/
│───presentation
|    │──app/
|    │──artist_detail/
|    │──artist_favorite/
|    │──artist_list/
|    └──artist_detail/
│───utils
|    │──http_client.dart
|    └──resource.dart
└───widgets
        │──album_card.dart
        |──artist_card.dart
        └──start.dart
```




## Using Dependencies
 - flutter_bloc -> Bloc patter Arquitecture
 - dio -> Http client
 - get_it -> Service locator
 - floor -> sqlite orm
 - equatable -> Equality Comparisons
 - cached_network_image -> cached image
 - url_launcher -> open browser

