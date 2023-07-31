import 'package:decisionapp/services/functions/firebaseFunctions.dart';
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
        builder: (context, model, child) => Container(
          padding: EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                PollsContainer(),
                SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            saveDecision(model.pollsWeights, model.pollTitle);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Decision Added'),
                          ));
                        },
                        child: Text('Upload Decision')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
