import 'package:flutter/material.dart';
import 'package:jify_flutter_app/src/blocs/search_image_bloc.dart';
import 'package:jify_flutter_app/src/models/image_search_response.dart';
import 'package:jify_flutter_app/src/ui/widgets/image_view_card_item.dart';

class ImageSearchDelegate extends SearchDelegate {
  final SearchBloc searchBloc = SearchBloc();

  ImageSearchDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 2) {
      return const Center(
          child: Text(
        "Search term must be longer than two letters.",
      ));
    }

    searchBloc.searchImage(query: query);

    return Container(
      child: StreamBuilder<ImageSearchResponse>(
        stream: searchBloc.getImageResStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.hits.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }
            if (snapshot.data!.hits.isNotEmpty) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.hits.length,
                    itemBuilder: (context, index) {
                      return ImageViewCard(
                          previewImageUrl: snapshot.data!.hits[index].webformatUrl,
                          largerImageUrl: snapshot.data!.hits[index].largeImageUrl);
                    }),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 2) {
      return const Center(
          child: Text(
        "Search term must be longer than two letters.",
      ));
    }

    searchBloc.searchImage(query: query);

    return Container(
      child: StreamBuilder<ImageSearchResponse>(
        stream: searchBloc.getImageResStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.hits.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }
            if (snapshot.data!.hits.isNotEmpty) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.hits.length,
                    itemBuilder: (context, index) {
                      return ImageViewCard(
                          previewImageUrl: snapshot.data!.hits[index].webformatUrl,
                          largerImageUrl: snapshot.data!.hits[index].largeImageUrl);
                    }),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
