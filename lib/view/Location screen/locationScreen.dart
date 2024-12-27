import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:queryui/utils/ColorConstants.dart';
import 'package:queryui/utils/appstyle.dart';
import 'package:queryui/view/customWidgets/customAppBar.dart';

class Locationscreen extends StatelessWidget {
  const Locationscreen({super.key});

  final String getLocation = """
    query {
      characters {
        info {
          count
          pages
          next
          prev
        }
        results {
          id
          image
          name
          type
          location {
            dimension
            residents {
              id
            }
            created
            name
            type
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
        options: QueryOptions(document: gql(getLocation)),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Locations",
                    style: Appstyle.getTextStyle(
                        fontSize: 25, color: ColorConstants.black),
                  ),
                  Column(
                    children: List.generate(
                      characters.length,
                      (index) {
                        var character = characters[index];
                        var location = character['location'];
                        var imageUrl = character['image'];

                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstants.Containerbordercolor[index %
                                  ColorConstants.Containerbordercolor.length],
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: imageUrl != null
                                    ? Image.network(imageUrl, fit: BoxFit.cover)
                                    : const Placeholder(),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      location != null &&
                                              location['name'] != null
                                          ? location['name']
                                          : "Unknown Location",
                                      style: Appstyle.getTextStyle(
                                          fontSize: 18,
                                          color: ColorConstants.black),
                                    ),
                                    Text(
                                      location != null &&
                                              location['type'] != null
                                          ? location['type']
                                          : "Unknown Type",
                                      style: Appstyle.getTextStyle(
                                          fontSize: 16,
                                          color: ColorConstants.darkgery),
                                    ),
                                    Text(
                                      location != null &&
                                              location['dimension'] != null
                                          ? location['dimension']
                                          : "Unknown Dimension",
                                      style: Appstyle.getSubTextStyle(
                                          fontSize: 14,
                                          color: ColorConstants.darkgery),
                                    ),
                                    Text(
                                      location != null &&
                                              location['created'] != null
                                          ? location['created']
                                          : "Unknown Created",
                                      style: Appstyle.getSubTextStyle(
                                          fontSize: 14,
                                          color: ColorConstants.lightGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
