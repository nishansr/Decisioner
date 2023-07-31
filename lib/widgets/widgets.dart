import 'package:decisionapp/services/providers/pollProvider.dart';
import 'package:decisionapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PollsContainer extends StatelessWidget {
  const PollsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PollsProvider>(
      builder: (context, model, child) => Card(
        child: Container(
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Add Polls Title'),
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: AppColors.primary,
                    maxLines: 2,
                    minLines: 1,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Enter Title';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      model.addPollTitle(value!);
                    },
                  ),
                )
              ],
            ),
            Column(
              children: [
                for (int i = 0; i < model.pollsOptions.length; i++)
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length == 0) {
                                    return 'enter option';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  model.pollsOptions[i] = value!;
                                  model.pollsWeights[value] = 0;
                                },
                              ),
                            ),
                            IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  model.removeOption();
                                },
                                icon: Icon(Icons.close)),
                          ],
                        ),
                      ))
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      model.addPollOptions();
                    },
                    child: Text('Add an option')),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
