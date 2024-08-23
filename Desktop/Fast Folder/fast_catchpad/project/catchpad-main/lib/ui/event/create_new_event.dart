import 'package:catchpad/managers/static_games_list.dart';
import 'package:catchpad/models/event/catchpad_event.dart';
import 'package:catchpad/models/game/game_model.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/widgets/buttons/cp_button_2.dart';
import 'package:catchpad/utils/widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/async.dart';

import 'game_drop_down.dart';

class CreateNewEvent extends ConsumerStatefulWidget {
  const CreateNewEvent({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateNewEventState();
}

class _CreateNewEventState extends ConsumerState<CreateNewEvent> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  late GameModel chooseGameModel;

  static Set<GameModel> gamesOnLeaderboard(WidgetRef ref) =>
      <GameModel>{StaticGamesList.formula(ref)};

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 18,
        title: Text(
          "Etkinlik Oluştur",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Etkinlik Başlık",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: controller1,
                decoration: const InputDecoration(
                  hintText: "Maraton Istanbul..",
                ),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Etkinlik Açıklama(Leaderboard Açıklama girmek istersek buraya yazılan gözükmesi için)",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: controller2,
                decoration: const InputDecoration(
                  hintText: "En hızlı sen ol ödülleri kap...",
                ),
                maxLines: 5,
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Etkinliğin Oyunu",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  GameDropdownWidget(
                    games: gamesOnLeaderboard(ref),
                    onGameSelected: (gameModel) {
                      chooseGameModel = gameModel;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CpButton2(
                      onPressed: () async {
                        final eventId = await nanoid(24);
                        final catchpadEventModel = CatchpadEvent(
                            eventId: eventId,
                            eventCreatedAt: DateTime.now().toLocal().toString(),
                            eventDescription: controller2.text,
                            eventGameId: chooseGameModel.id,
                            eventJoinUserIdList: [],
                            eventLastDate: DateTime.now()
                                .add(const Duration(days: 4))
                                .toString(),
                            eventName: controller1.text,
                            eventStatus: true,
                            eventGameName: chooseGameModel.metaData.name);

                        final resAdd = await ref
                            .read(catchPadEventManager.notifier)
                            .create(ref, catchPadEvent: catchpadEventModel);
                        if (resAdd) {
                          CustomDialogs.successTitleAndOk(ref, "Başarılı",
                              "Etkinlik Başarılı Bir Şekilde Oluşturuldu");
                        } else {
                          CustomDialogs.failed(
                              ref, "Hata!", "Bir şeyler ters gitti");
                        }
                      },
                      child: const Text("Oluştur")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
