import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/Domain/Models/Hive/UserModel.dart';
import 'package:spotify/Domain/Bloc/AutenticateBloc.dart';
import 'package:spotify/Dependency/injection.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Domain/Shared/prefs.dart';
import 'package:spotify/Domain/services/push_notifications_service.dart';
import 'package:spotify/Views/Utils/routes.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  configureInjection(Env.dev);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'Spotify',
      options: const FirebaseOptions(
          appId: '686677707661',
          apiKey: 'AIzaSyDLhs8_wWi-VuWbe5NK_devhEd0Y_LVguw',
          messagingSenderId: '',
          projectId: 'spotify-ceae1'));
  await SharedPreferences.getInstance();
  final prefs = UserPreferences();
  await prefs.initPrefs();
  final appDocumentDir = await path.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('User');
  await PushNotificationService.initializeApp();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Stat());
}

class Stat extends StatefulWidget {
  const Stat({Key? key}) : super(key: key);

  @override
  _StatState createState() => _StatState();
}

class _StatState extends State<Stat> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<AuntenticateBloc>()),
        ChangeNotifierProvider(create: (context) => getIt<SpotifyProvider>())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    PushNotificationService.messagesStream.listen((event) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(event)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify',
      theme: ThemeData(
        primaryColor: Colors.black,
        primaryColorLight: Colors.white,
        primarySwatch: Colors.purple,
      ),
      routes: routes,
      initialRoute: '/splash',
    );
  }
}
