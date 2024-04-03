import 'package:flutter/material.dart';

import '../components/appbarr.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBarr(),),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    child: Icon(Icons.account_circle_rounded,size: 80,color: Colors.yellow,),
                  ),
                ),
                SizedBox(height: 10),
                Text("PULINDU VIDMAL",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8) ),
                ),
                SizedBox(height: 70,),
              ],
              ),
           Padding(
             padding: const EdgeInsets.only(left: 50),
             child: Row(
               children: [
                 Text("Name:",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),fontSize: 12)),
               ],
             ),
           ),
            SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text("Pulindu Vidmal",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height: 14,),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text("Email:",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text("vidmailpulindu@gmail.com",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height: 14,),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text("Contact Number:",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text("0719892557",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),fontSize: 16))
                ],
              ),
            ),
            SizedBox(height: 14,),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text("Join Date:",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text("18th january 2022",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),fontSize: 16))
                ],
              ),
            ),
          ],
        ),
      ),
    );


  }
}
