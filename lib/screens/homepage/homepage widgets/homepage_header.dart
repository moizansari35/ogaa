import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/constants/routes/routes.dart';
import 'package:ogaa/constants/sized_box.dart';
import 'package:ogaa/provider/app_provider.dart';
import 'package:ogaa/screens/fetch_plants_screen/fetch_plants_screen.dart';
import 'package:ogaa/screens/location/location_widget.dart';
import 'package:ogaa/screens/weather/weather_widget.dart';
import 'package:provider/provider.dart';

class HomepageHeader extends StatefulWidget {
  const HomepageHeader({
    super.key,
  });

  @override
  State<HomepageHeader> createState() => _HomepageHeaderState();
}

class _HomepageHeaderState extends State<HomepageHeader> {
  @override
  Widget build(BuildContext context) {
    // AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return Container(
      height: context.screenHeight / 3,
      decoration: const BoxDecoration(
        color: MyColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Location",
                      style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    5.height,
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: MyColors.secondaryColor,
                          size: 20,
                        ),
                        LocationWidget(),
                        Icon(
                          Icons.arrow_drop_down,
                          color: MyColors.secondaryColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                const WeatherWidget(),
              ],
            ),
            const Divider(
              color: MyColors.whiteColor,
            ),
            const Text(
              'Hi Whats up✌️,',
              style: TextStyle(
                color: MyColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: MyColors.blackColor,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            Consumer<AppProvider>(
              builder: (context, appProvider, child) {
                if (appProvider.isLoading) {
                  return const CircularProgressIndicator(
                    color: MyColors.whiteColor,
                  );
                }

                // If user info is loaded
                final userModel = appProvider.getUserInfo;

                return Text(
                  "Welcome, ${userModel.name} !", // Replace `name` with the actual property
                  style: const TextStyle(
                    color: MyColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: MyColors.blackColor,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Routes.routesInstance.push(
                        widget: const FetchPlantsScreen(),
                        context: context,
                      );
                    },
                    child: Container(
                      height: context.screenHeight / 15,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            MyColors.secondaryColor,
                            MyColors.primaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: MyColors.whiteColor,
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.eco,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Plant Intelligence',
                            style: TextStyle(
                              color: MyColors.whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                10.width,
                Container(
                  height: context.screenHeight / 15,
                  width: context.screenHeight / 15,
                  decoration: BoxDecoration(
                    color: MyColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: MyColors.primaryColor,
                    size: 28,
                  ),
                ),
              ],
            ),
            5.height
          ],
        ),
      ),
    );
  }
}
