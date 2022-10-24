import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:order_receipt/widgets/dividers.dart';

class Feedback extends StatefulWidget {

  const Feedback({super.key});

  @override
  FeedbackState createState() => FeedbackState();
}

class FeedbackState extends State<Feedback> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //     padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Row(children: [
          //           const CircleAvatar(
          //             backgroundColor: Colors.cyan,
          //             radius: 15,
          //             child: FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 15),
          //           ),
          //           Column(children: [
          //             Text(namaMitra),
          //             const SizedBox(height: 5),
          //             Text(
          //               tanggal,
          //               style: const TextStyle(
          //                 color: Colors.grey,
          //               ),
          //             ),
          //           ],
          //           )
          //         ])
          //       ],
          //     )
          // ),
          const NormalDivider(),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(
              children: [
                const Text(
                  "Bagaimana makanannya?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 60,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                  unratedColor: Colors.grey[100],
                  glow: false,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Ceritakan pengalamanmu disini",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLength: 200,
                  maxLines: 4,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: (Colors.grey[200])!, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: (Colors.grey[200])!, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  cursorColor: Colors.black,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}