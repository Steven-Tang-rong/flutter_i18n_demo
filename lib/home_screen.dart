import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

enum Gender {male, female, other}

class HomeScreen extends StatefulWidget {
  final Function(Locale) setLocale;

  const HomeScreen({super.key, required this.setLocale});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _itemCount = 0;
  double _price = 99.99;
  double _rating = 4.5;
  Gender _selectedGender = Gender.other;
  String _name = 'Steven';

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.language),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                localizations.lastUpdated(DateTime.now()),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(localizations.itemCount(_itemCount)),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(
                        () => _itemCount = (_itemCount - 1).clamp(0, 100)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => _itemCount++),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(localizations.price(_price)),
              const SizedBox(height: 20),
              Text(localizations.rating(_rating)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(localizations.gender),
                  const SizedBox(width: 10),
                  DropdownButton<Gender>(
                    iconSize: 40,
                    iconEnabledColor: Theme.of(context).primaryColor,
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                    value: _selectedGender,
                    items: Gender.values.map((Gender gender) {
                      return DropdownMenuItem<Gender>(
                        value: gender,
                        child: Text(
                          switch (gender) {
                            Gender.male => localizations.male,
                            Gender.female => localizations.female,
                            Gender.other => localizations.other,
                          },
                        ),
                      );
                    }).toList(),
                    onChanged: (Gender? newValue) {
                      if (newValue != null) {
                        setState(() => _selectedGender = newValue);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(localizations.greetUser(_selectedGender.toString(), _name)),
            ],
          ),
        ),
      ),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 32.0),
              child: Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.change_language),
            onTap: () => _showLanguageDialog(context),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.change_language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  widget.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('中文'),
                onTap: () {
                  widget.setLocale(const Locale('zh'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('日本語'),
                onTap: () {
                  widget.setLocale(const Locale('ja'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
