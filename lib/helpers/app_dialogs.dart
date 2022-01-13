import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:rating_dialog/rating_dialog.dart';

Future<void> showD({BuildContext context, String title, String content = ""}) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      });
}

// showRatingDialog(context,Function onSubmit) {
//   return showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) => RatingDialog(
//       icon: Icon(Icons.star),
//         title: "Rate Worker",
//         description: "Tap a start to give your rating",
//         onSubmitPressed: onSubmit,

//         submitButton: 'Submit'),
//   );
// }

Future<void> showRatingDialog({BuildContext context, Function onUpdate,Function onSubmit}) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Rate worker"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Text("Tap a start to give your rating"),
              RatingBar(
                initialRating: 3,
                itemCount: 5,
                allowHalfRating: false,
                ratingWidget: RatingWidget(
                  empty: Icon(Icons.star_border,color: Colors.yellow),
                  full: Icon(Icons.star,color: Colors.yellow),
                  half:Icon(Icons.star_half,color: Colors.yellow)
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: onUpdate,

              )
            ],
            ),
            actions: [
              FlatButton(onPressed: onSubmit, child: Text('Submit',style: TextStyle(fontSize: 18,color: Theme.of(context).accentColor),))
            ],
            );
      });
}
