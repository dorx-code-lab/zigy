import 'package:flutter/material.dart';

class BackBar extends StatefulWidget {
  final String text;
  final bool showIcon;
  final Function onPressed;
  final Widget action;
  final IconData icon;

  BackBar({
    Key key,
    @required this.icon,
    this.showIcon = true,
    @required this.onPressed,
    @required this.text,
    this.action,
  }) : super(key: key);

  @override
  State<BackBar> createState() => _BackBarState();
}

class _BackBarState extends State<BackBar> {
  String mode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 2,
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.showIcon
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: widget.onPressed ??
                            () {
                              Navigator.of(context).pop();
                            },
                        child: CircleAvatar(
                          child: IconButton(
                            icon: Icon(
                              widget.icon ?? Icons.arrow_back_ios_rounded,
                            ),
                            onPressed: widget.onPressed ??
                                () {
                                  Navigator.of(context).pop();
                                },
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 5,
                    ),
              Expanded(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (widget.action != null) widget.action,
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
