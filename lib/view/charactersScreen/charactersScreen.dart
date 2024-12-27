import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:queryui/utils/ColorConstants.dart';
import 'package:queryui/utils/appstyle.dart';
import 'package:queryui/view/customWidgets/customAppBar.dart';

class Charactersscreen extends StatelessWidget {
  const Charactersscreen({super.key});

  final String getCharacters = """
query {
  characters {
    info {
      count
    }
    results {
      id
      name
      image
      status
      species
      type
      origin {
        id
      }
      gender
      image
      location {
        id
      }
      episode {
        id
      }
    }
  }
}
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Query(
        options: QueryOptions(document: gql(getCharacters)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text("Error: ${result.exception.toString()}"));
          }

          var characters = result.data?['characters']?['results'];

          if (characters == null || characters.isEmpty) {
            return const Center(child: Text("No characters found"));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    var character = characters[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: ColorConstants.boxShadow,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(character['image']),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                character['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Appstyle.getTextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.black,
                                ),
                              ),
                              Text(
                                character['species'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Appstyle.getSubTextStyle(
                                  fontSize: 15,
                                  color: ColorConstants.darkgery,
                                ),
                              ),
                              Text(
                                character['gender'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Appstyle.getSubTextStyle(
                                  fontSize: 14,
                                  color: ColorConstants.lightGrey,
                                ),
                              ),
                              Text(
                                character['episode'] != null &&
                                        character['episode'].isNotEmpty
                                    ? 'Episodes: ${character['episode'].length}'
                                    : 'No episodes available',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Appstyle.getSubTextStyle(
                                  fontSize: 14,
                                  color: ColorConstants.lightGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
