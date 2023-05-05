import 'package:flutter/material.dart';
import 'package:zigy/constants/constants.dart';
import 'package:zigy/models/user.dart';
import 'package:zigy/services/services.dart';
import 'package:zigy/widgets/user_details_bottom_sheet.dart';

import 'widgets.dart';

class SingleUser extends StatefulWidget {
  final int userID;
  final UserModel userModel;

  const SingleUser({
    Key key,
    @required this.userID,
    @required this.userModel,
  }) : super(key: key);

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  @override
  Widget build(BuildContext context) {
    return widget.userModel == null
        ? FutureBuilder(
            future: ApiService.getUserDetail(
              widget.userID,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LoadingWidget();
              } else {
                return body(
                  snapshot.data,
                );
              }
            },
          )
        : body(
            widget.userModel,
          );
  }

  body(UserModel userModel) {
    return GestureDetector(
      onTap: () {
        UIServices().showDatSheet(
          UserDetailsBottomSheet(
            userModel: userModel,
          ),
          true,
          context,
        );
      },
      child: Material(
        elevation: standardElevation,
        borderRadius: standardBorderRadius,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: UIServices().getImageProvider(
                  userModel.avatar,
                ),
              ),
              subtitle: Text("Email: ${userModel.email}"),
              title: Text(
                "${userModel.firstName ?? ""} ${userModel.secondName ?? ""}",
              ),
            )
          ],
        ),
      ),
    );
  }
}
