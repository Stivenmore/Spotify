import 'package:flutter/material.dart';
import 'package:spotify/Domain/Models/Stander/artistModel.dart';
import 'package:spotify/Domain/Models/Stander/trackArtistModel.dart';
import 'package:spotify/Domain/Models/Stander/tracksModel.dart';
import 'package:spotify/Views/Home/Details/DetailTrack.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class DetailsArtists extends StatefulWidget {
  final ArtistsModel artistsModel;
  final List<TrackArtistModel> trackList;
  DetailsArtists(
      {Key? key, required this.artistsModel, required this.trackList})
      : super(key: key);

  @override
  _DetailsArtistsState createState() => _DetailsArtistsState();
}

class _DetailsArtistsState extends State<DetailsArtists> {
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff212121),
          title: Text(
            widget.artistsModel.name!,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          height: responsive.height,
          width: responsive.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height: 350,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 280,
                          width: responsive.width,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/no-image.jpg',
                              image: widget.artistsModel.iconlist![0].url!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 240,
                            left: responsive.wp(14),
                            right: responsive.wp(15),
                            bottom: 10,
                            child: SizedBox(
                              height: 90,
                              width: responsive.wp(100),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.trackList[0].images!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/no-image.jpg',
                                            image: widget.trackList[0]
                                                .images![index].url!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'TrackList',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: responsive.height - 455,
                  width: responsive.width,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: widget.trackList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailTrack(
                                          playlist: '',
                                          trackModel: TrackModel(
                                              artists:
                                                  widget.trackList[0].artists,
                                              images:
                                                  widget.trackList[0].images,
                                              name:
                                                  widget.trackList[index].name,
                                              href:
                                                  widget.trackList[index].href,
                                              id: widget.trackList[index].id,
                                              previusURl: widget
                                                  .trackList[index].previusURl),
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey)),
                              height: 70,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/no-image.jpg',
                                        image:
                                            widget.trackList[0].images![0].url!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          widget.artistsModel.name!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          widget.trackList[index].name!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.amber[400],
                                            size: 34,
                                          ),
                                        )),
                                  )
                                ],
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
