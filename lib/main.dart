import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pref_with_provider/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeDataChange.createSharedPrefObject();
  runApp(ChangeNotifierProvider<ThemeDataChange>(
      create: (BuildContext context) {
        return ThemeDataChange();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeDataChange>(context, listen: false).loadThemeFromSharedPref();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeDataChange>(context).themeColor,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text('Tema Seçimi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SwitchListTile(
              title: Provider.of<ThemeDataChange>(context).isGreen
                  ? const Text('Yeşil Tema')
                  : const Text('Kırmızı  Tema'),
              onChanged: (_) {
                return Provider.of<ThemeDataChange>(context, listen: false).changeTheme();
              },
              value: Provider.of<ThemeDataChange>(context).isGreen,
            ),
            const Card(
              child: ListTile(
                title: Text("Yapılacaklar"),
                trailing: Icon(Icons.check_box),
              ),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              child: const Text("Ekle"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
