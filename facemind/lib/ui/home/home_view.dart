import 'package:facemind/api/api_client.dart';
import 'package:facemind/ui/home/analyze_view.dart';
import 'package:facemind/ui/home/calendar_view.dart';
import 'package:facemind/ui/home/my_page_view.dart';
import 'package:flutter/material.dart';
import 'package:facemind/utils/global_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(initialPage: 1);
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.whiteColor,
      child: SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 3,
          initialIndex: 1, //홈을 기본으로
          child: Scaffold(
            backgroundColor: GlobalColors.whiteColor,
            body: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                // 페이지가 변경될 때 호출되는 함수
                setState(() {
                  _selectedIndex = value;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // 통계
                AnalyzeView(
                  date: DateTime.now(),
                ), // 캘린더 홈
                const CalendarView(),
                // 마이페이지
                const MyPageView(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: '통계',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: '캘린더',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '마이',
                ),
              ],
              selectedItemColor: GlobalColors.mainColor, // 선택된 아이템 색상
              unselectedItemColor: GlobalColors.darkgrayColor, // 선택되지 않은 아이템 색상
              backgroundColor: GlobalColors.whiteColor, // 배경색
              // 선택된 아이템의 라벨 스타일
              selectedLabelStyle: TextStyle(
                fontSize: 9,
                color: GlobalColors.mainColor,
              ),
              // 선택되지 않은 아이템의 라벨 스타일
              unselectedLabelStyle: TextStyle(
                fontSize: 9,
                color: GlobalColors.darkgrayColor,
              ),
              currentIndex: _selectedIndex,
              // 그림자 효과 강도
              elevation: 10,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                  _pageController.animateToPage(
                    _selectedIndex,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
