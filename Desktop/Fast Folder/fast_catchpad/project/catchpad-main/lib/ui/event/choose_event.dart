import 'package:catchpad/models/event/catchpad_event.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseEvent extends ConsumerStatefulWidget {
  const ChooseEvent({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ChooseEventState();
}

class _ChooseEventState extends ConsumerState<ChooseEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 18,
        title: Text(
          "Etkinlik Aktif Et",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: FutureBuilder<List<CatchpadEvent>>(
        future:
            ref.read(catchPadEventManager.notifier).getCatchpadEventList(ref),
        builder: (BuildContext context,
            AsyncSnapshot<List<CatchpadEvent>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null)
          {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          final list = snapshot.data;
          return list!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      final perEvent = list[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                              value:
                                  ref.watch(catchPadEventManager) == perEvent,
                              onChanged: (val) {
                                if (val!) {
                                  ref
                                      .read(catchPadEventManager.notifier)
                                      .chooseCurrentEvent(ref,
                                          catchpadEvent: perEvent);
                                } else {
                                  ref
                                      .read(catchPadEventManager.notifier)
                                      .chooseCurrentEvent(ref,
                                          catchpadEvent: null);
                                }
                              }),
                          Column(
                            children: [
                              Text(
                                perEvent.eventName ?? "İsimsiz",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                perEvent.eventGameName ?? "İsimsiz",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                )
              : Text(
                  "Aktif olan etkinlik bulunmamakta!",
                  style: Theme.of(context).textTheme.titleMedium,
                );
        },
      ),
    );
  }
}
