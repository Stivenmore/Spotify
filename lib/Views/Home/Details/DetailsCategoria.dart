import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Domain/Models/Stander/categoriesModel.dart';
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
      if (scrollController.position.extentBefore ==
          scrollController.position.maxScrollExtent) {
        widget.onNextPage();
      }
      print('before' + scrollController.position.extentBefore.toString());
      print('Max' + scrollController.position.maxScrollExtent.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final spotifybloc = Provider.of<SpotifyProvider>(context, listen: true);
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
          spotifybloc.clearOPT();
          return Future.value(true);
        },
        child: SizedBox(
          height: responsive.height,
          width: responsive.width,
          child: Column(
            children: [
              Container(
                color: Colors.red,
                height: 310,
                width: responsive.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Nombre',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              widget.categoriesModel!.name!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Cantidad de playlist',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              spotifybloc.playListOptModel.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Colaboracion',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              spotifybloc.playListOptModel[0].collaborative ==
                                      true
                                  ? 'Si'
                                  : 'No',
                              style: const TextStyle(color: Colors.white),
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
              SizedBox(
                height: (responsive.height - 396),
                width: responsive.width,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemCount: 17,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          width: responsive.width,
                          height: 90,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/no-image.jpg',
                                  image: spotifybloc
                                      .playListModel[index].images![0].url!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(spotifybloc
                                        .playListOptModel[index].name!),
                                    Text(
                                      '${spotifybloc.playListOptModel[index].description!.substring(0, 28)}...',
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
