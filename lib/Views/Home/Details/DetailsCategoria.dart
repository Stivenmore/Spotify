import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Domain/Models/Stander/categoriesModel.dart';
import 'package:spotify/Domain/Models/Stander/playlistModel.dart';
import 'package:spotify/Views/Home/Details/DetailsPlayList.dart';
import 'package:spotify/Views/Utils/Animations/FadeAnimation.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class DetailsCategorias extends StatefulWidget {
  final Function onNextPage;
  final CategoriesModel? categoriesModel;
  const DetailsCategorias(
      {Key? key, required this.onNextPage, this.categoriesModel})
      : super(key: key);

  @override
  _DetailsCategoriasState createState() => _DetailsCategoriasState();
}

class _DetailsCategoriasState extends State<DetailsCategorias> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      double max = scrollController.position.maxScrollExtent;
      double value = max - 800;
      if (scrollController.position.extentBefore >= value) {
        widget.onNextPage();
        setState(() {
          max = scrollController.position.maxScrollExtent;
        });
      }
      print('before' + scrollController.position.extentBefore.toString());
      print('value' + value.toString());
    });
    super.initState();
  }

  List<PlaylistModel> list = [];
  @override
  Widget build(BuildContext context) {
    final spotifybloc = Provider.of<SpotifyProvider>(context, listen: true);
    setState(() {
      list = spotifybloc.playListOptModel;
    });
    Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff212121),
        title: Text(
          widget.categoriesModel!.name!,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff212121),
      body: WillPopScope(
        onWillPop: () async {
          spotifybloc.clearOPTPlays();
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
                            image: widget.categoriesModel!.iconlist![0].url!,
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
                                'PlayLists',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
                          onTap: () async {
                            final resp = await spotifybloc.getTrackListOpt(
                                playlistID: list[index].id!);
                            if (resp == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'No es posible completar la acción')));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPlayList(
                                            onNextPage: () =>
                                                spotifybloc.getTrackListOpt(
                                                    playlistID:
                                                        list[index].id!),
                                            playlistModel: list[index],
                                          )));
                            }
                          },
                          child: FadeAnimation(
                            (1500 + (index * 10)),
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
                                            spotifybloc
                                                .playListOptModel[index].name!,
                                            style: TextStyle(
                                                color: Colors.amber[400],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            spotifybloc.playListOptModel[index]
                                                        .description!.length >
                                                    28
                                                ? '${spotifybloc.playListOptModel[index].description!.substring(0, 28)}...'
                                                : '${spotifybloc.playListOptModel[index].description!}...',
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
