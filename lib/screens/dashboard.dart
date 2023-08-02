import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionapp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('decisions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final docs = snapshot.data!.docs;
                    print(docs[0]['title']);
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return PollsWidget(
                            decisionId: docs[index].id,
                            decisionTitle: docs[index]['title'],
                            creatorId: docs[index]['uid'],
                            pollWeights: docs[index]['pollsWeights'],
                            usersWhoVoted: docs[index]['usersWhoVoted']);
                      },
                    );
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
