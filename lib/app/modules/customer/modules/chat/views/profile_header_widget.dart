import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/customer/modules/booking/views/create_booking_page.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String techId;

  const ProfileHeaderWidget({
    required this.name,
    required this.techId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 80,
        padding: EdgeInsets.all(16).copyWith(left: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.white),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // buildIcon(Icons.call),
                    // SizedBox(width: 12),
                    // buildIcon(Icons.videocam),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.bookmark_add),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => CreateBookingPage(techId: techId),
                            ));
                      },
                      label: const Text("Book"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFFA74385),
                          ),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(color: Color(0xFFA74385))))),
                    ),
                  ],
                ),
                SizedBox(width: 4),
              ],
            )
          ],
        ),
      );

  Widget buildIcon(IconData icon) => Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white54,
        ),
        child: Icon(icon, size: 25, color: Colors.white),
      );
}
