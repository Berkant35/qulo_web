import 'package:catchpad/models/audio/melody.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectMusicPage extends ConsumerStatefulWidget {
  const SelectMusicPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SelectMusicPageState();
}

class _SelectMusicPageState extends ConsumerState<SelectMusicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select"),
      ),
      body: FutureBuilder<List<Melody?>>(
          future: ref.read(currentMelodyManager.notifier).getMelodyList(ref),
          builder: (context, snapshot) {
            final listData = snapshot.data;
            return snapshot.connectionState == ConnectionState.done
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: listData!.length,
                    itemBuilder: (context, index) {
                      var perMelody = listData[index];
                      return Row(
                        children: [
                          Checkbox(
                            value: (ref.watch(currentMelodyManager) != null &&
                                ref.watch(currentMelodyManager)?.melodyId ==
                                    perMelody!.melodyId),
                            onChanged: (val) {
                              ref
                                  .read(currentMelodyManager.notifier)
                                  .getMelodyAndSet(ref, perMelody!.melodyId!);
                            },
                          ),
                          Text(
                            perMelody!.title ?? "unknown",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      );
                    })
                : const Center(child: CircularProgressIndicator.adaptive());
          }),
    );
  }
}
