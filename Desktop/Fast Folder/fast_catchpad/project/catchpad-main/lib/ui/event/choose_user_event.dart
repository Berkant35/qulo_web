import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/event/event_customer.dart';
import '../../prov/global_providers.dart';

class ChooseUserEvent extends ConsumerStatefulWidget {
  const ChooseUserEvent({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ChooseUserEventState();
}

class _ChooseUserEventState extends ConsumerState<ChooseUserEvent> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 18,
        title: Text(
          "Yarışmacıyı Seç",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller,
                  onChanged: (text) {
                    controller.text = text;
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                      hintText: "Kullanıcı Adına Göre Ara"),
                ),
              )),
          Expanded(
            flex: 8,
            child: FutureBuilder<List<EventCustomer>>(
              future: ref
                  .read(catchPadEventManager.notifier)
                  .getEventCustomers(ref),
              builder: (BuildContext context,
                  AsyncSnapshot<List<EventCustomer>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                List<EventCustomer> filteredList = snapshot.data!
                    .where((eventCustomer) => eventCustomer.username!
                        .toLowerCase()
                        .contains(controller.text.toLowerCase()))
                    .toList();

                return filteredList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final perLoginUser = filteredList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${perLoginUser.username}",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Checkbox(
                                    value: ref.watch(
                                                catchpadEventCompetitorManager) !=
                                            null &&
                                        ref
                                                .watch(
                                                    catchpadEventCompetitorManager)!
                                                .username ==
                                            perLoginUser.username,
                                    onChanged: (val) {
                                      if (val!) {
                                        ref
                                            .read(catchpadEventCompetitorManager
                                                .notifier)
                                            .choose(perLoginUser);
                                      } else {
                                        ref
                                            .read(catchpadEventCompetitorManager
                                                .notifier)
                                            .choose(null);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          "Eşleşen kullanıcı bulunamadı.",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
