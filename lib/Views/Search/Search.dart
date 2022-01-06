import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Domain/Models/Stander/searchModelTrack.dart';
import 'package:spotify/Domain/Models/Stander/tracksModel.dart';
import 'package:spotify/Domain/Shared/prefs.dart';
import 'package:spotify/Views/Home/Details/DetailTrack.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class SearchCourseDelegate extends SearchDelegate {
  final _pref = UserPreferences();
  @override
  String get searchFieldLabel =>
      _pref.locale == 'CO' ? 'Buscar tu cancion' : 'Search to song';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final spotifybloc = Provider.of<SpotifyProvider>(context, listen: false);
    Responsive responsive = Responsive(context);
    if (query.isEmpty) {
      return _emptyContainer();
    }
    spotifybloc.getStreamSearch(query);

    return StreamBuilder(
        stream: spotifybloc.suggestionStream,
        builder: (context, AsyncSnapshot<List<SearchModelTrack>?> snap) {
          if (snap.hasData) {
            return Container(
              height: responsive.height - 90,
              child: ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailTrack(
                                      playlist: '',
                                      trackModel: TrackModel(
                                          artists: snap.data![index].artists,
                                          images: snap.data![index].images,
                                          name: snap.data![index].name,
                                          href: snap.data![index].href,
                                          id: snap.data![index].id,
                                          previusURl:
                                              snap.data![index].previusURl),
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/no-image.jpg',
                                  image: snap.data![index].images![0].url!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: responsive.wp(60),
                                    child: Text(
                                      snap.data![index].name!,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: responsive.wp(60),
                                    child: Text(
                                      snap.data![index].artists![0].name!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('No tengo data'),
            );
          }
        });
  }

  Widget _emptyContainer() {
    return Container(
      child: const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final spotifybloc = Provider.of<SpotifyProvider>(context, listen: false);
    Responsive responsive = Responsive(context);
    if (query.isEmpty) {
      return _emptyContainer();
    }
    spotifybloc.getStreamSearch(query);

    return StreamBuilder(
        stream: spotifybloc.suggestionStream,
        builder: (context, AsyncSnapshot<List<SearchModelTrack>?> snap) {
          if (snap.hasData) {
            return Container(
              height: responsive.height - 90,
              child: ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailTrack(
                                      playlist: '',
                                      trackModel: TrackModel(
                                          artists: snap.data![index].artists,
                                          images: snap.data![index].images,
                                          name: snap.data![index].name,
                                          href: snap.data![index].href,
                                          id: snap.data![index].id,
                                          previusURl:
                                              snap.data![index].previusURl),
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/no-image.jpg',
                                  image: snap.data![index].images![0].url!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: responsive.wp(60),
                                    child: Text(
                                      snap.data![index].name!,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: responsive.wp(60),
                                    child: Text(
                                      snap.data![index].artists![0].name!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('No tengo data'),
            );
          }
        });
  }
}

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Search', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
