import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

class FullCartScreen extends StatelessWidget {
  const FullCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: checkoutSection(context),
        appBar: AppBar(
          flexibleSpace: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.teal,
                Colors.teal.withOpacity(0.5),
              ]))),
          elevation: 5,
          title: Text("My Cart"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.delete),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: 60),
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 130,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(15),
                        bottomRight: const Radius.circular(15)),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                          width: 130,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PdHtXka2-bDDww6Nuect3Mt9IwpE4v4HNw&usqp=CAU",
                                  ),
                                  fit: BoxFit.fill))),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                  "Name",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(16),
                                        onTap: () {},
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red[900],
                                          ),
                                        )))
                              ],
                            ),
                            Row(
                              children: [
                                Text("Price:"),
                                SizedBox(
                                  width: 2,
                                ),
                                Text("50.9 SR"),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Text("Sub Total:"),
                                SizedBox(
                                  width: 2,
                                ),
                                Text("50.9 SR"),
                              ],
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Text("Ships free:"),
                                  Spacer(),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4.0),
                                      // splashColor: ,
                                      onTap: () {},
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Entypo.minus,
                                            color: Colors.red,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 12,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.teal,
                                          Colors.teal.withOpacity(0.5),
                                        ], stops: [
                                          0.0,
                                          0.7
                                        ]),
                                      ),
                                      child: Text(
                                        '154',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4.0),
                                      // splashColor: ,
                                      onTap: () {},
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.green[700],
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              }),
        ));
  }

  Widget checkoutSection(BuildContext context) {
    return Container(
      //  decoration: BoxDecoration(border: BorderRadius.only()),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Material(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red[900],
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Checkout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total:',
              style: TextStyle(
                  // color: Theme.of(context).textSelectionColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '179.0 SR',
              //textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.cyan[700],
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
