import 'dart:io';

import 'package:flutter/material.dart';

enum AuthFormType { signIn, signUp, reset }

class UIServices {
  Future<dynamic> showDatSheet(
    Widget sheet,
    bool willThisThingNeedScrolling,
    BuildContext context, {
    double height,
    bool enableDrag = true,
    bool useFramework = true,
    Function onClose,
  }) {
    return showModalBottomSheet(
      context: context,
      enableDrag: enableDrag,
      isScrollControlled: willThisThingNeedScrolling,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SizedBox(
          height: height ?? MediaQuery.of(context).size.height * 0.92,
          child: useFramework
              ? StatefulBuilder(builder: (context, setIt) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (onClose != null) {
                            onClose();
                          }

                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).canvasColor,
                          child: Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              16,
                            ),
                            topRight: Radius.circular(
                              16,
                            ),
                          ),
                          child: Container(
                            color: Theme.of(context).canvasColor,
                            child: sheet,
                          ),
                        ),
                      )
                    ],
                  );
                })
              : sheet,
        );
      },
    );
  }

  ImageProvider<Object> getImageProvider(
    dynamic asset,
  ) {
    return asset == null
        ? null
        : asset is File
            ? FileImage(asset)
            : asset.toString().trim().contains(
                      "assets/images",
                    )
                ? AssetImage(
                    asset,
                  )
                : NetworkImage(
                    asset,
                  );
  }

  DecorationImage decorationImage(
    dynamic asset,
    bool darken,
  ) {
    return asset == null
        ? null
        : DecorationImage(
            image: asset is File
                ? FileImage(asset)
                : asset.toString().trim().contains(
                          "assets/images",
                        )
                    ? AssetImage(
                        asset,
                      )
                    : NetworkImage(
                        asset,
                      ),
            fit: BoxFit.cover,
            colorFilter: darken
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  )
                : null,
          );
  }
}

class MySliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  MySliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(MySliverAppBarDelegate oldDelegate) {
    return false;
  }
}
