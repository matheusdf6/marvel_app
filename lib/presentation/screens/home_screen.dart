import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:marvel_app/presentation/stores/character_list/character_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget buildLoading(bool loading) =>
      loading ? const CircularProgressIndicator() : const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CharacterList>(context);
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
        title: const Text('Marvel API'),
      ),
      body: Observer(
        builder: (context) => Column(
          children: [
            Text(store.errorMessage),
            ElevatedButton(
              onPressed: !store.loading ? store.loadCharacters : () {},
              child: const Text('Carregar'),
            ),
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                separatorBuilder: (_, index) => const Divider(),
                scrollDirection: Axis.vertical,
                itemCount: store.characters.length,
                itemBuilder: (bc, index) => ListTile(
                  title: Text(store.characters[index].name),
                ),
              ),
            ),
            buildLoading(store.loading)
          ],
        ),
      ),
    );
  }
}
