import 'package:decisionapp/services/providers/pollProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDecision extends StatelessWidget {
  const AddDecision({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PollsProvider>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.all(14.0),
        ),
      ),
    );
  }
}
