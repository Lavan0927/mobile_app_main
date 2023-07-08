import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/router_name.dart';
import 'state_injector.dart';
import 'utils/k_strings.dart';
import 'utils/my_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await StateInjector.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: StateInjector.repositoryProviders,
      child: MultiBlocProvider(
        providers: StateInjector.blocProviders,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: KStrings.appName,
          theme: MyTheme.theme,
          onGenerateRoute: RouteNames.generateRoute,
          initialRoute: RouteNames.animatedSplashScreen,
          builder: (context, child) {
            return MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
        ),
      ),
    );
  }
}
