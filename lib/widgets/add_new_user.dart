import 'package:flutter/material.dart';
import 'package:zigy/services/api_services.dart';
import 'package:zigy/services/communications.dart';
import 'package:zigy/services/navigation.dart';
import 'package:zigy/widgets/top_back_bar.dart';

class AddNewUserBottomSheet extends StatefulWidget {
  const AddNewUserBottomSheet({Key key}) : super(key: key);

  @override
  State<AddNewUserBottomSheet> createState() => _AddNewUserBottomSheetState();
}

class _AddNewUserBottomSheetState extends State<AddNewUserBottomSheet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BackBar(
            icon: null,
            onPressed: null,
            text: "Add a user",
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Name",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Type here",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Job",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: jobController,
                    decoration: InputDecoration(
                      hintText: "Type here",
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) {
                CommunicationServices().showSnackBar(
                  "Please provide a name",
                  context,
                );
              } else {
                if (jobController.text.trim().isEmpty) {
                  CommunicationServices().showSnackBar(
                    "Please provide a job",
                    context,
                  );
                } else {
                  int tt = await ApiService().createUser(
                    nameController.text.trim(),
                    jobController.text.trim(),
                  );

                  if (tt == null) {
                    CommunicationServices().showSnackBar(
                      "Error creating the user",
                      context,
                    );
                  } else {
                    NavigationService().pop();

                    CommunicationServices().showSnackBar(
                      "Success",
                      context,
                    );
                  }
                }
              }
            },
            child: Text(
              "Add user",
            ),
          )
        ],
      ),
    );
  }
}
