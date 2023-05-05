import 'package:flutter/material.dart';
import 'package:zigy/constants/constants.dart';
import 'package:zigy/models/user.dart';
import 'package:zigy/widgets/widgets.dart';

class UserDetailsBottomSheet extends StatefulWidget {
  final UserModel userModel;
  const UserDetailsBottomSheet({
    Key key,
    @required this.userModel,
  }) : super(key: key);

  @override
  State<UserDetailsBottomSheet> createState() => _UserDetailsBottomSheetState();
}

class _UserDetailsBottomSheetState extends State<UserDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackBar(
          icon: null,
          onPressed: null,
          text: "User Details",
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: standardBorderRadius,
                  child: Image.network(
                    widget.userModel.avatar,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${widget.userModel.firstName ?? ""} ${widget.userModel.secondName ?? ""}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.userModel.email ?? "",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
