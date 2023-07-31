import 'package:cloud_firestore/cloud_firestore.dart';
import 'authFunctions.dart';

saveDecision(Map pollsWeights, String title) async {
  await FirebaseFirestore.instance.collection('decisions').add({
    'pollsWeights': pollsWeights,
    'uid': currUser!.uid,
  });
}
