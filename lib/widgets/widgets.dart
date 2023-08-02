import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionapp/services/providers/pollProvider.dart';
import 'package:decisionapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polls/polls.dart';

import '../services/functions/authFunctions.dart';

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
            model.pollsOptions == 5
                ? Container()
                : Row(
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

class PollsWidget extends StatefulWidget {
  final String decisionId;
  final String decisionTitle;
  final String creatorId;
  final Map usersWhoVoted;
  final Map pollWeights;
  const PollsWidget({
    Key? key,
    required this.decisionId,
    required this.decisionTitle,
    required this.creatorId,
    required this.pollWeights,
    required this.usersWhoVoted,
  }) : super(key: key);

  @override
  State<PollsWidget> createState() => _PollsWidgetState();
}

class _PollsWidgetState extends State<PollsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 0.0,
        shadowColor: Colors.grey.withOpacity(0.2),
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: BorderSide(color: Colors.grey.shade600.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.decisionTitle,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Polls(
              iconColor: Colors.black,
              children: [
                for (int i = 0;
                    i < widget.pollWeights.keys.toList().length;
                    i++)
                  Polls.options(
                      title: widget.pollWeights.keys.toList()[i],
                      value: (widget.pollWeights.values.toList()[i]).toDouble())
              ],
              allowCreatorVote: true,
              question: const Text(''),
              outlineColor: AppColors.primary,
              currentUser: currUser!.uid,
              creatorID: widget.creatorId,
              voteData: widget.usersWhoVoted,
              leadingBackgroundColor: AppColors.primary.withOpacity(0.6),
              userChoice: widget.pollWeights.keys
                  .toList()
                  .indexOf(widget.usersWhoVoted[widget.decisionId]),
              onVoteBackgroundColor: AppColors.primary.withOpacity(0.5),
              backgroundColor: Colors.transparent,
              onVote: (choice) async {
                Map userWhoVoted = widget.usersWhoVoted;
                Map thisPollweights = widget.pollWeights;

                var selectedOption =
                    widget.pollWeights.keys.toList()[choice - 1];
                setState(() {
                  thisPollweights[selectedOption] =
                      thisPollweights[selectedOption] + 1;
                  userWhoVoted[currUser!.uid] =
                      widget.pollWeights.keys.toList()[choice - 1];
                });
                await FirebaseFirestore.instance
                    .collection('decisions')
                    .doc(widget.decisionId)
                    .update({
                  'pollWeights': thisPollweights,
                  'usersWhoVoted': userWhoVoted
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
