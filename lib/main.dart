import 'package:floyer/helpers/color_conveter.dart';
import 'package:floyer/pages/home/home_page.dart';
import 'package:floyer/providers/profile_provider.dart';
import 'package:floyer/router.dart';
import 'package:floyer/services/local_storage.dart';
import 'package:floyer/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().initialize();
  await NotificationService().initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => ProfileProvider()..initialize(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, tp, child) {
        final lightTheme = ThemeData.light();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Geo Link",
          home: const HomePage(),
          theme: lightTheme.copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorConverter().hexToColor(
                tp.currentProfile.colorSchemeSeed,
              )!,
            ),
            textTheme: GoogleFonts.montserratTextTheme(),
          ),
          themeMode: ThemeMode.light,
          navigatorKey: AppRouter.navigatorKey,
        );
      },
    );
  }
}
