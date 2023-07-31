import 'package:decisionapp/services/providers/pollProvider.dart';
import 'package:decisionapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDecision extends StatefulWidget {
  const AddDecision({super.key});

  @override
  State<AddDecision> createState() => _AddDecisionState();
}

class _AddDecisionState extends State<AddDecision> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PollsProvider>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                PollsContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
