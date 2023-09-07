import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/core/presentation/widgets/custom_asset_icon.dart';
import 'package:pokedex/features/home_page/data/enums/home_page_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageMenu _currentPage = HomePageMenu.home;
  final _pageViewController = PageController();

  @override
  void initState() {
    _pageViewController.addListener(() {
      setState(() {
        _currentPage =
            HomePageMenu.values[_pageViewController.page?.round() ?? 0];
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _headerWidget,
            Expanded(
              child: PageView(
                controller: _pageViewController,
                children: HomePageMenu.values.map((e) => e.page).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget get _headerWidget {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const CustomAssetIcon(
                asset: 'assets/images/configuration-icon.png',
                size: 23,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.bell),
            ),
          ],
        ),
        Image.asset(
          'assets/images/pokemon-logo.png',
          width: MediaQuery.of(context).size.width * .5,
        ),
      ],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: HomePageMenu.values
            .map(
              (item) => InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  setState(() {
                    _pageViewController.animateToPage(
                      HomePageMenu.values.indexOf(item),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: item.icon(
                          context: context,
                          isSelected: item == _currentPage,
                        ),
                      ),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: item == _currentPage
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
