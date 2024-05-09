import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/my_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userId;
  late Stream<DocumentSnapshot> userStream;


  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    userStream = FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
  }

  String formatDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: MyAppBar(image: 'assets/Logo.png', actionSection: true,),),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: StreamBuilder(
            stream: userStream,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show loading indicator while fetching data
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Text('No data found!'); // Handle case where no data exists for the user
              }
              // If data is available, build the UI
              var userData = snapshot.data!.data() as Map<String, dynamic>;

              var joinDate = (userData['joinedDate'] as Timestamp).toDate(); // Assuming 'joinDate' is a field in your Firestore document

            return Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.black,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(userData['first name'] ?? "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8) ),
                    ),
                    SizedBox(height: 70,),
                  ],
                  ),
               Padding(
                 padding: const EdgeInsets.only(left: 50),
                 child: Row(
                   children: [
                     Text("Name:",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),fontSize: 12)),
                   ],
                 ),
               ),
                SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Text(userData['first name'] ?? "",style: TextStyle(color: Theme.of(context).colorScheme.onBackground,fontSize: 16)),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Text("Email:",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Text(userData['email'] ?? "",style: TextStyle(color: Theme.of(context).colorScheme.onBackground,fontSize: 16)),
                    ],
                  ),
                ),
                // SizedBox(height: 20,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 50),
                //   child: Row(
                //     children: [
                //       Text("Contact Number:",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),fontSize: 12)),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 2,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 50),
                //   child: Row(
                //     children: [
                //       Text("0719892557",style: TextStyle(color: Theme.of(context).colorScheme.onBackground,fontSize: 16))
                //     ],
                //   ),
                // ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Text("Joined Date:",style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Text(formatDate(joinDate),style: TextStyle(color: Theme.of(context).colorScheme.onBackground,fontSize: 16))
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );


  }
}
