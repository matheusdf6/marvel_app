import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:marvel_app/presentation/screens/character_screen.dart';
import 'package:marvel_app/presentation/stores/character_list/character_list.dart';
import 'package:marvel_app/presentation/widgets/character_card.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget buildList(BuildContext context, CharacterList store, ScrollController controller) =>
      store.errorMessage == ''
          ? Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 64.0),
                controller: controller,
                scrollDirection: Axis.vertical,
                itemCount: store.characters.length,
                itemBuilder: (bc, index) => CharacterCard(
                  name: store.characters[index].name,
                  imageUrl: store.characters[index].thumbnail,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterScreen(
                          params: CharacterScreenParams(
                            character: store.characters[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const Text(
                      'Erro!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      store.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: store.loadCharacters,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                ],
              ),
            );

  Widget buildLoading(bool loading) => loading
      ? const Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        )
      : const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CharacterList>(context);
    store.loadCharacters();
    final _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange &&
          !store.loading) {
        store.loadCharacters();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca Marvel'),
      ),
      body: Observer(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Column(
            children: [
              buildList(context, store, _scrollController),
              buildLoading(store.loading),
            ],
          ),
        ),
      ),
    );
  }
}
