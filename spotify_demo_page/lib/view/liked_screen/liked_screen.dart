import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:spotify_demo_page/dummydb.dart';
import 'package:spotify_demo_page/utils/constants/app_style.dart';
import 'package:spotify_demo_page/utils/constants/color_constants.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  _LikedScreenState createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = false;

  int _currentIndex = 0;

  double _floatingButtonTop = 0.25;
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 200) {
        setState(() {fi
          _showAppBar = true;
        });
      } else {
        setState(() {
          _showAppBar = false;
        });
      }

      setState(() {
        // Adjust the floating button's position
        _floatingButtonTop = 0.25 - (_scrollController.offset / 200);
        if (_floatingButtonTop < 0.08) {
          _floatingButtonTop = 0.09;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: screenHeight * 0.30,
                pinned: true,
                backgroundColor:
                    _showAppBar ? ColorConstant.bluecolor : Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorConstant.bluecolor,
                          ColorConstant.Blackcolor
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100),
                        Text("Liked Songs",
                            style: AppStyle.getTitleStyle(
                                fontSize: 30, color: ColorConstant.white)),
                        const SizedBox(height: 10),
                        Text("${Dummydb.Music.length} songs",
                            style: AppStyle.getTextStyle(
                                fontSize: 16, color: ColorConstant.white)),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.arrow_circle_down_outlined,
                                color: Colors.white,
                                size: screenWidth * 0.08,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon:const Icon(HugeIcons.strokeRoundedShuffle),
                                    color:
                                        const Color.fromARGB(255, 44, 231, 51),
                                    iconSize: screenWidth * 0.08,
                                  ),
                                  const SizedBox(width: 80),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                title: _showAppBar
                    ? Text(
                        'Liked Songs',
                        style: AppStyle.getTitleStyle(
                            fontSize: 16, color: ColorConstant.white),
                      )
                    : null,
                leading: _showAppBar
                    ? IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          //Navigator.pop(context);
                        },
                      )
                    : null,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final song = Dummydb.Music[index];
                    return ListTile(
                      leading: Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[800],
                        ),
                        child: Image.asset(
                          song['image'] ?? 'assets/image/default.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        song['name'] ?? 'Unknown Title',
                        style: AppStyle.getTextStyle(
                            fontSize: screenWidth * 0.05,
                            color: ColorConstant.white),
                      ),
                      subtitle: Text(
                        song['artist'] ?? 'Unknown Artist',
                        style: AppStyle.getTextStyle(
                            fontSize: screenWidth * 0.04,
                            color: ColorConstant.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: screenWidth * 0.05,
                        ),
                        onPressed: () {},
                      ),
                    );
                  },
                  childCount: Dummydb.Music.length,
                ),
              ),
            const  SliverToBoxAdapter(
                child: SizedBox(height: 25),
              ),
            ],
          ),

          // Floating Play Button
          Positioned(
            top: screenHeight * _floatingButtonTop,
            right: screenWidth * 0.5 - screenWidth * 0.40 - 10,
            child: Container(
              height: screenWidth * 0.14,
              width: screenWidth * 0.14,
              decoration: BoxDecoration(
                color: ColorConstant.green,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Icon(
                  Icons.play_arrow,
                  color: ColorConstant.Blackcolor,
                  size: screenWidth * 0.09,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: ColorConstant.green,
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedHome02),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedSearch02),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedSpotify),
            label: 'Premium',
          ),
        ],
      ),
    );
  }
}
