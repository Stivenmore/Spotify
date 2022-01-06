import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:spotify/Domain/Models/Stander/tracksModel.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Views/Components/player_widget.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class DetailTrack extends StatefulWidget {
  final String? playlist;
  final TrackModel? trackModel;
  const DetailTrack({Key? key, this.playlist, this.trackModel})
      : super(key: key);

  @override
  _DetailTrackState createState() => _DetailTrackState();
}

class _DetailTrackState extends State<DetailTrack> {
  final ScrollController scrollController = ScrollController();
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spotifybloc = Provider.of<SpotifyProvider>(context, listen: false);
    Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff212121),
        title: Text(
          widget.playlist!,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff212121),
      body: WillPopScope(
        onWillPop: () async {
          return Future.value(true);
        },
        child: SizedBox(
          height: responsive.height,
          width: responsive.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.trackModel!.name!,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.trackModel!.artists![0].name!,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/no-image.jpg',
                        image: widget.trackModel!.images![0].url!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PlayerWidget(
                    url: widget.trackModel!.previusURl!,
                    audioPlayer: audioPlayer),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  width: responsive.wp(90),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.trackModel!.images!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/no-image.jpg',
                                image: widget.trackModel!.images![index].url!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
