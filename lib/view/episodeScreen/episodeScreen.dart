import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:queryui/utils/appstyle.dart';
import 'package:queryui/utils/colorconstants.dart';
import 'package:queryui/view/customWidgets/customAppBar.dart';

class Episodescreen extends StatefulWidget {
  const Episodescreen({super.key});

  @override
  State<Episodescreen> createState() => _EpisodescreenState();
}

class _EpisodescreenState extends State<Episodescreen> {
 final String getEpisode= """
    query {
      episodes {
        info {
          count
          pages
          next
          prev
        }
        results {
          id
          name
          air_date
          created
          characters {
            id
            name
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
        options: QueryOptions(document: gql(getEpisode)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text("Error: ${result.exception.toString()}"));
          }

          var episodes = result.data?['episodes']?['results'];

          if (episodes == null || episodes.isEmpty) {
            return const Center(child: Text("No episodes found"));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Episodes",
                    style: Appstyle.getTextStyle(
                        fontSize: 25, color: ColorConstants.black),
                  ),
                  Column(
                    children: List.generate(
                      episodes.length,
                      (index) {
                        var episode = episodes[index];
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                episode['name'],
                                style: Appstyle.getTextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.black,
                                ),
                              ),
                              Text(
                                "Air Date: ${episode['air_date']}",
                                style: Appstyle.getSubTextStyle(
                                  fontSize: 16,
                                  color: ColorConstants.darkgery,
                                ),
                              ),
                              Text(
                                "Characters: ${episode['characters'].length}",
                                style: Appstyle.getSubTextStyle(
                                  fontSize: 14,
                                  color: ColorConstants.lightGrey,
                                ),
                              )
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
