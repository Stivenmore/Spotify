import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Domain/Models/Stander/playlistModel.dart';
import 'package:spotify/Domain/Models/Stander/tracksModel.dart';
import 'package:spotify/Views/Home/Details/DetailTrack.dart';
import 'package:spotify/Views/Utils/Animations/FadeAnimation.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class DetailsPlayList extends StatefulWidget {
  final PlaylistModel? playlistModel;
  final Function? onNextPage;
  const DetailsPlayList({Key? key, this.playlistModel, this.onNextPage})
      : super(key: key);

  @override
  _DetailsPlayListState createState() => _DetailsPlayListState();
}

class _DetailsPlayListState extends State<DetailsPlayList> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      double max = scrollController.position.maxScrollExtent;
      double value = max - 800;
      if (scrollController.position.extentBefore >= value) {
        widget.onNextPage!();
        setState(() {
          max = scrollController.position.maxScrollExtent;
        });
      }
    });
    super.initState();
  }

  List<TrackModel> list = [];
  @override
  Widget build(BuildContext context) {
    final spotifybloc = Provider.of<SpotifyProvider>(context, listen: true);
    setState(() {
      list = spotifybloc.trackListOptModel;
    });
    Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff212121),
        title: Text(
          widget.playlistModel!.name!,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff212121),
      body: WillPopScope(
        onWillPop: () async {
          spotifybloc.clearOPTTrack();
          return Future.value(true);
        },
        child: SizedBox(
          height: responsive.height,
          width: responsive.width,
          child: Column(
            children: [
              Container(
                height: 310,
                width: responsive.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                        child: spotifybloc.globalstates == true
                            ? const LinearProgressIndicator(
                                color: Colors.white,
                                backgroundColor: Color(0xff212121),
                              )
                            : null,
                      ),
                      SizedBox(
                        height: 249,
                        width: responsive.width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/no-image.jpg',
                            image: widget.playlistModel!.images![0].url!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: const [
                              Text(
                                'Tracks',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: spotifybloc.globalstates,
                child: SizedBox(
                  height: (responsive.height - 404),
                  width: responsive.width,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailTrack(
                                          playlist: widget.playlistModel!.name,
                                          trackModel: list[index],
                                        )));
                          },
                          child: FadeAnimation(
                            (1500 + (index * 5)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: responsive.width,
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/no-image.jpg',
                                        image: list[index].images![0].url!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            list[index].name!.length > 20
                                                ? '${list[index].name!.substring(0, 20)}...'
                                                : '${list[index].name!}...',
                                            style: TextStyle(
                                                color: Colors.amber[400],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            list[index]
                                                        .artists![0]
                                                        .name!
                                                        .length >
                                                    28
                                                ? '${list[index].artists![0].name!.substring(0, 28)}...'
                                                : '${list[index].artists![0].name!}...',
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.star,
                                          color: Colors.amber[400],
                                        ),
                                        alignment: Alignment.centerRight,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
