import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/constants/sized_box.dart';
import 'package:ogaa/provider/app_provider.dart';
import 'package:ogaa/screens/homepage/homepage%20widgets/animated_slider.dart';
import 'package:ogaa/screens/homepage/homepage%20widgets/home_row.dart';
import 'package:ogaa/screens/homepage/homepage%20widgets/homepage_header.dart';
import 'package:ogaa/screens/plants_screens/plants_grid_page.dart';
import 'package:ogaa/screens/plants_screens/plants_gridview.dart';
import 'package:ogaa/screens/plants_screens/plants_list.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 4, vsync: this);
  //   AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
  //   appProvider.getUserInfoFirebase();
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Defer state updates until after the build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppProvider appProvider =
          Provider.of<AppProvider>(context, listen: false);
      appProvider.getUserInfoFirebase();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const HomepageHeader(),
            10.height,
            const Text(
              '#Special for You',
              style: TextStyle(
                color: MyColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            5.height,
            Expanded(
              child: HomeAnimatedSlider(),
            ),
            20.height,
            HomeRow(
              text1: "Recommended for you",
              text2: "See all",
              onTap: () {
                // Navigate to the PlantsGridPage to show all plants
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PlantsGridPage(allPlants: PlantLists.allPlants),
                  ),
                );
              },
            ),
            10.height,
            TabBar(
              controller: _tabController,
              indicatorColor: MyColors.primaryColor,
              labelColor: MyColors.primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Indoor"),
                Tab(text: "Outdoor"),
                Tab(text: "Garden"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  PlantGrid(plants: PlantLists.allPlants),
                  PlantGrid(plants: PlantLists.indoorPlants),
                  PlantGrid(plants: PlantLists.outdoorPlants),
                  PlantGrid(plants: PlantLists.gardenPlants),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
