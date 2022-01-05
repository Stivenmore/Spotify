import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Bloc/AutenticateBloc.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Domain/Models/Hive/UserModel.dart';
import 'package:spotify/Views/Autentication/Login.dart';
import 'package:spotify/Views/Home/Details/DetailsCategoria.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class Home extends StatefulWidget {
  final VoidCallback? open;
  final Function? onNextPage;
  Home({Key? key, this.onNextPage, this.open}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final box = Hive.box<UserModel>('User');
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 1000) {
        widget.onNextPage!();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final spotifybloc = Provider.of<SpotifyProvider>(context, listen: true);
    final boxkeylast = box.keys.last;
    final user = box.get(boxkeylast) as UserModel;
    Responsive responsive = Responsive(context);
    final autenticatebloc =
        Provider.of<AutenticateProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff212121),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: responsive.height,
              width: responsive.width,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: spotifybloc.globalstates == true
                        ? const LinearProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Color(0xff212121),
                          )
                        : null,
                  ),
                  SliverAppBar(
                    backgroundColor: const Color(0xff212121),
                    leading: IconButton(
                        onPressed: widget.open,
                        icon: const Icon(
                          Icons.dehaze_rounded,
                          color: Colors.white,
                        )),
                    centerTitle: true,
                    title: Text(
                      '¡Hola ${user.name}!',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: IgnorePointer(
                      ignoring: spotifybloc.globalstates,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Recomendaciones',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 185,
                              width: responsive.width,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: spotifybloc.albumModel.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 120,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/no-image.jpg',
                                                image: spotifybloc
                                                    .albumModel[index]
                                                    .images![0]
                                                    .url!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            spotifybloc.albumModel[index]
                                                .artists![0].name!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: IgnorePointer(
                      ignoring: spotifybloc.globalstates,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Categorias',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 240,
                              width: responsive.width,
                              child: ListView.builder(
                                  controller: scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: spotifybloc.categoriesModel.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        final resp =
                                            await spotifybloc.getPlayListOpt(
                                                categoryID: spotifybloc
                                                    .categoriesModel[index]
                                                    .id!);
                                        if (resp == false) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'No es posible completar la acción')));
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DetailsCategorias(
                                                      onNextPage: () => spotifybloc
                                                          .getPlayListOpt(
                                                              categoryID:
                                                                  spotifybloc
                                                                      .categoriesModel[
                                                                          index]
                                                                      .id!),
                                                      categoriesModel: spotifybloc
                                                              .categoriesModel[
                                                          index])));
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 170,
                                              width: 150,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/no-image.jpg',
                                                  image: spotifybloc
                                                      .categoriesModel[index]
                                                      .iconlist![0]
                                                      .url!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              spotifybloc
                                                  .categoriesModel[index].name!,
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              'Principales',
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: IgnorePointer(
                      ignoring: spotifybloc.globalstates,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quizá te pueda gustar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 240,
                              width: responsive.width,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: spotifybloc.playListModel.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 170,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/no-image.jpg',
                                                image: spotifybloc
                                                    .playListModel[index]
                                                    .images![0]
                                                    .url!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            spotifybloc
                                                .playListModel[index].name!,
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            'Originales',
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
