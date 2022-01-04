import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Bloc/AutenticateBloc.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Domain/Models/Hive/UserModel.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final box = Hive.box<UserModel>('User');
  
  @override
  Widget build(BuildContext context) {
    final boxkeylast = box.keys.last;
    final user = box.get(boxkeylast) as UserModel;
    Responsive responsive = Responsive(context);
    final autenticatebloc =
        Provider.of<AutenticateProvider>(context, listen: true);
    final spotifybloc = Provider.of<SpotifyProvider>(context, listen: true);
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '¡Hola ${user.name}!',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Container(
                                padding: const EdgeInsets.only(top: 1),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(16)),
                                child: const Center(
                                  child: Icon(
                                    Icons.search,
                                    size: 26,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recomendaciones',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 150,
                            width: responsive.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: spotifybloc.albumModel.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 120,
                                      width: 150,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/no-image.jpg',
                                        image: spotifybloc
                                            .albumModel[index].images![0].url!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
