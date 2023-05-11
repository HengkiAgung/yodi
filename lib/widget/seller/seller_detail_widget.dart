import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerDetailWidget extends StatelessWidget {
  const SellerDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            // seller.user.image != "" ?
            // CircleAvatar(
            //   backgroundImage: NetworkImage(seller.user.image ?? "")
            // )
            // :
            const CircleAvatar(
              backgroundImage: AssetImage("images/profile_placeholder.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "seller.user.username",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "seller.city",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}