import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigy/constants/constants.dart';
import 'package:zigy/services/services.dart';
import 'package:zigy/widgets/widgets.dart';

import '../widgets/add_new_user.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentPage = 1;
  final ApiController searchController = Get.put(ApiController());

  @override
  void initState() {
    super.initState();

    searchController.getPaginatedUsers(_currentPage);
  }

  Future<void> reset() {
    _currentPage = 1;
    searchController.clearAndReset();
    return searchController.getPaginatedUsers(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: reset,
          child: Column(
            children: [
              BackBar(
                icon: Icons.menu,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                text: "Home",
              ),
              Expanded(
                child: Obx(() {
                  return Stack(
                    children: [
                      searchController.foundUsers.isEmpty
                          ? Center(
                              child: Text(
                                'No Movie Found',
                              ),
                            )
                          : ListView(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              children: searchController.foundUsers.map<Widget>(
                                (e) {
                                  return Column(
                                    children: [
                                      SingleUser(
                                        userID: e.id,
                                        userModel: e,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  );
                                },
                              ).followedBy(
                                [
                                  ElevatedButton(
                                    onPressed: () {
                                      _currentPage = _currentPage + 1;

                                      searchController
                                          .getPaginatedUsers(_currentPage);
                                    },
                                    child: Text(
                                      "Load more",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      "Built by Simeon with extra love and care",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ).toList(),
                            ),
                      if (searchController.isLoading.value)
                        Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Material(
                              elevation: standardElevation,
                              borderRadius: standardBorderRadius,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    LoadingWidget(
                                      size: 30,
                                    ),
                                    Text(
                                      "Loading",
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UIServices().showDatSheet(
            AddNewUserBottomSheet(),
            true,
            context,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
