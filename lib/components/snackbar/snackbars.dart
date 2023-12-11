import 'package:flutter/material.dart';

class SnackBars {
  successMessage(BuildContext context,
      {required String title, required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: EdgeInsets.all(8),
        height: 120,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 19, 154, 78),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(
              Icons.check,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Flexible(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            )),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                icon: Icon(Icons.close))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0,
    ));
  }

  failureMessage(BuildContext context,
      {required String title, required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: EdgeInsets.all(8),
        height: 120,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 215, 20, 20),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(
              Icons.cancel,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Flexible(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            )),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                icon: Icon(Icons.close))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0,
    ));
  }

  warningMessage(BuildContext context,
      {required String title, required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: EdgeInsets.all(8),
        height: 120,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 228, 137, 18),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(
              Icons.error,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Flexible(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            )),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                icon: Icon(Icons.close))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0,
    ));
  }
}
