import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:marvel_app/domain/entities/character.dart';

class CharacterScreen extends StatelessWidget {
  final CharacterScreenParams params;

  const CharacterScreen({Key? key, required this.params}) : super(key: key);

  String getDescription() {
    return params.character.description != ''
        ? params.character.description
        : 'Não há descrição para o(a) personagem';
  }

  Widget getComicList() {
    return params.character.comics.isNotEmpty
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text(
                  params.character.comics[index],
                  style: const TextStyle(
                    height: 1.5,
                  ),
                ),
              ),
              childCount: params.character.comics.length,
            ),
          )
        : const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Não há quadrinhos com esse persgonagem'),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            title: const Text('Detalhes'),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                params.character.thumbnail,
                fit: BoxFit.cover,
                color: Colors.black26,
                colorBlendMode: BlendMode.multiply,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                  child: Text(
                    params.character.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    getDescription(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      height: 1.5,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                  child: const Text(
                    'Quadrinhos',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          getComicList()
        ],
      ),
    );
  }
}

class CharacterScreenParams {
  final Character character;

  CharacterScreenParams({
    required this.character,
  });
}
