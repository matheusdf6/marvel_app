import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:marvel_app/domain/entities/character.dart';
import 'package:marvel_app/presentation/stores/character_details/character_details.dart';
import 'package:provider/provider.dart';

class CharacterScreen extends StatelessWidget {
  final CharacterScreenParams params;

  const CharacterScreen({Key? key, required this.params}) : super(key: key);

  String getDescription() {
    return params.character.description != ''
        ? params.character.description
        : 'Não há descrição para o(a) personagem';
  }

  Widget getComicList(CharacterDetails store) {
    return SliverToBoxAdapter(
      child: Observer(
        builder: (context) {
          if( store.loading ) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if( store.comics.isEmpty ) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Não há quadrinhos com esse persgonagem'),
            );
          }
          return SizedBox(
            height: 240.0,
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              scrollDirection: Axis.horizontal,
              itemCount: store.comics.length,
              itemBuilder: (bc, index) => Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(store.comics[index].title),
                    ));
                  },
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Image(
                      image: NetworkImage(store.comics[index].thumbnail),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CharacterDetails>(context);
    store.loadCharacterDetails(params.character.id);

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
          getComicList(store)
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
