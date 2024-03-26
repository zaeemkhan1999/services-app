import 'package:flutter/material.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/services/Service.dart';

class ListMenus {
  String title;
  String image;
  Color color;
  ListMenus({this.title, this.image, this.color});
}

class GridMenuScreen extends StatefulWidget {
  @override
  _GridMenuScreenState createState() => _GridMenuScreenState();
}

class _GridMenuScreenState extends State<GridMenuScreen> {
  List<ListMenus> listMenus = [
    ListMenus(
      title: 'Carpenter',
      image: 'assets/images/carpenter.png',
      color: Color.fromRGBO(110, 95, 255, 1),
    ),
    ListMenus(
      title: 'Electrician',
      image: 'assets/images/electrician.png',
      color: Color.fromRGBO(255, 160, 8, 1),
    ),
    ListMenus(
      title: 'Plumber',
      image: 'assets/images/plumber.png',
      color: Color.fromRGBO(138, 193, 17, 1),
    ),
    ListMenus(
      title: 'Gardener',
      image: 'assets/images/gardener.png',
      color: Color.fromRGBO(0, 215, 226, 1),
    ),
    ListMenus(
      title: 'Masonry',
      image: 'assets/images/masonry.png',
      color: Color.fromRGBO(203, 131, 255, 1),
    ),
    ListMenus(
      title: 'Painter',
      image: 'assets/images/painter.png',
      color: Color.fromRGBO(255, 95, 95, 1),
    ),
    ListMenus(
      title: 'AC Technician',
      image: 'assets/images/actechnician.png',
      color: Color.fromRGBO(47, 167, 255, 1),
    ),
    ListMenus(
      title: 'CCTV',
      image: 'assets/images/cctv.png',
      color: Color.fromRGBO(247, 38, 232, 1),
    ),
    ListMenus(
      title: 'More',
      image: 'assets/images/plus_icon.png',
      color: Color.fromRGBO(147, 147, 147, 1),
    ),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    int count = 3;
    int total_elements = this.listMenus.length;
    if (ScreenSizeConfig.safeBlockHorizontal * 100 < 360) {
      count = 2;
    } else {
      count = 3;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        backgroundColor: SColors.PrimaryColorPurple,
        flexibleSpace: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: _inkwells(),
        ),
      ),
      body: GridView.count(
        crossAxisCount: count,
        children: List.generate(total_elements, (index) {
          return _cardOfService(listMenus[index]);
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            ),
            label: 'Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.grey),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey),
            label: 'Profile',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings, color: Colors.grey),
          //   label: '',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: SColors.PrimaryColorPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _inkwells() {
    return Container(
      color: SColors.PrimaryColorPurple,
      child: Row(
        children: [
          Container(
            width: ScreenSizeConfig.safeBlockHorizontal * 50,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  0,
                  0),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        ScreenSizeConfig.safeBlockHorizontal * 0.5,
                        ScreenSizeConfig.safeBlockHorizontal * 5,
                        ScreenSizeConfig.safeBlockHorizontal * 5,
                        0),
                    child: Opacity(
                      opacity: 0.4,
                      child: Container(
                        height: ScreenSizeConfig.safeBlockVertical * 4.25,
                        width: ScreenSizeConfig.safeBlockHorizontal * 7.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.sort,
                            color: Colors.white,
                            size: ScreenSizeConfig.safeBlockHorizontal * 6),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: ScreenSizeConfig.safeBlockHorizontal * 50,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  0),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Opacity(
                      opacity: 0.4,
                      child: Container(
                        height: ScreenSizeConfig.safeBlockVertical * 4.5,
                        width: ScreenSizeConfig.safeBlockHorizontal * 7.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.search,
                            color: Colors.white,
                            size: ScreenSizeConfig.safeBlockHorizontal * 6),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardOfService(ListMenus) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          ScreenSizeConfig.safeBlockHorizontal * 2,
          ScreenSizeConfig.safeBlockVertical * 1,
          ScreenSizeConfig.safeBlockHorizontal * 2,
          ScreenSizeConfig.safeBlockVertical * 0.2),
      child: TextButton(
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    height: ScreenSizeConfig.safeBlockVertical * 12.5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ListMenus.color,
                    ),
                  ),
                ),
                Container(
                  height: ScreenSizeConfig.safeBlockVertical * 12.5,
                  width: ScreenSizeConfig.safeBlockHorizontal * 20,
                  child: Padding(
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 4),
                    child: Image.asset(
                      ListMenus.image,
                      height: ScreenSizeConfig.safeBlockVertical * 12.5,
                      width: ScreenSizeConfig.safeBlockHorizontal * 20,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              ListMenus.title,
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Service(
                    title: ListMenus.title.toUpperCase(),
                    id: "609e9a426ddd8201ccfb02d0")),
          );
        },
      ),
    );
  }
}
