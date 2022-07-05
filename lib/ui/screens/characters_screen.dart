import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../constant/colors.dart';
import '../widgets/character_item.dart';
import '../widgets/widgets_to_display_in_item.dart';

import '../../data/model/character_model.dart';
import '../../logic/cubit/characters_cubit.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacter;
  late List<Character> resultOfSearchCharacter;
  bool isSearching = false;
  bool isConnected = true;
  final searchTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // isSearching = false;
    BlocProvider.of<CharactersCubit>(context).getAllCharacter();
    resultOfSearchCharacter = [];
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: Colors.black),
    );
  }

  // BUILD WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.primaryColor,
      appBar: isConnected
          ? AppBar(
              backgroundColor: ColorsApp.secondaryColor,
              leading: isSearching
                  ? BackButton(
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          isSearching = false;
                        });
                      },
                    )
                  : Container(),
              title: isSearching ? buildSearchField() : buildAppBarTitle(),
              actions: buildAppBarActions(),
            )
          : null,
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          isConnected = connectivity != ConnectivityResult.none;

          if (isConnected) {
            return buildBlocWidget();
          } else {
            removeAppBar();
            return noInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
      // buildBlocWidget(),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacter = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return Container(
      color: ColorsApp.primaryColor,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildCharacterList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 2 / 3,
        ),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount:
            isSearching ? resultOfSearchCharacter.length : allCharacter.length,
        itemBuilder: (context, index) {
          return CharacterItem(
              character: (isSearching)
                  ? resultOfSearchCharacter[index]
                  : allCharacter[index]);
        });
  }

  Widget buildSearchField() {
    return TextField(
      autofocus: true,
      controller: searchTextEditingController,
      cursorColor: Colors.red,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "searching here...",
      ),
      onChanged: (searchedCharacter) {
        addSearchedCharacterForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedCharacterForItemsToSearchedList(String searchedCharacter) {
    resultOfSearchCharacter = allCharacter
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            stopSearch();
          },
          icon: const Icon(Icons.clear),
          color: Colors.white,
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ];
    }
  }

  void stopSearch() {
    clearSearching();
    setState(() {
      isSearching = false;
    });
    Navigator.pop(context);
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    setState(() {
      isSearching = true;
    });
  }

  void clearSearching() {
    searchTextEditingController.clear();
    resultOfSearchCharacter.clear();
  }

  Widget noInternetWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Positioned(
            height: 50.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: const Color(0xFFEE4400),
              child: const Center(
                child: Text('OFFLINE'),
              ),
            ),
          ),
          const SizedBox(height: 80),
          Center(
            child: Image.asset("assets/images/offline.png"),
          ),
        ],
      ),
    );
  }

  void removeAppBar() {
    setState(() {
      isConnected = false;
    });
  }
}
