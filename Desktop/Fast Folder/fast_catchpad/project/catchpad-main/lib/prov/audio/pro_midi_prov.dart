import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_midi_pro/flutter_midi_pro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/audio/melody.dart';

class MidiProNotifier extends StateNotifier<MidiPro?> {
  MidiProNotifier(MidiPro? state) : super(null);
  final String _sf2Path = 'assets/audio/sf2/grand_piano.sf2';

  void initialize(WidgetRef ref) {
    state = MidiPro();
    state!.loadSoundfont(sf2Path: _sf2Path);
  }

  void outLayerNumbers(List<int> list) {
    List<int> veriSeti = list;

    veriSeti.sort(); // Verileri küçükten büyüğe sırala

    double medyan;
    double altKesimNoktasi;
    double ustKesimNoktasi;

    // Medyanı hesapla
    if (veriSeti.length % 2 == 0) {
      int index1 = veriSeti.length ~/ 2;
      int index2 = index1 - 1;
      medyan = (veriSeti[index1] + veriSeti[index2]) / 2;
    } else {
      int index = veriSeti.length ~/ 2;
      medyan = veriSeti[index].toDouble();
    }

    // Aykırı değerleri hesapla
    double d =
        (veriSeti[(veriSeti.length ~/ 4) * 3] - veriSeti[veriSeti.length ~/ 4])
            .toDouble();
    double altDortlukDerinlik = 1.5 * d;
    double ustDortlukDerinlik = 1.5 * d;

    altKesimNoktasi = veriSeti[veriSeti.length ~/ 4] - altDortlukDerinlik;
    ustKesimNoktasi = veriSeti[(veriSeti.length ~/ 4) * 3] + ustDortlukDerinlik;

    // Aykırı değerleri kontrol et
    List<int> aykiriDegerler = [];
    for (int veri in veriSeti) {
      if (veri < altKesimNoktasi || veri > ustKesimNoktasi) {
        aykiriDegerler.add(veri);
      }
    }
  }

  Future<int> play(WidgetRef ref, int noteCounter) async {
    int currentIndex = noteCounter;

    for (int i = 0; i < 64; i++) {
      final perNote = ref.read(currentMelodyManager)!.notes![currentIndex];
      final nextNote = ref.read(currentMelodyManager)!.notes![currentIndex + 1];
      state!.playMidiNote(
          velocity: (perNote.velocity! * 100).toInt(),
          midi: perNote.midi!.toInt());
      await Future.delayed(Duration(
          milliseconds: ((nextNote.time! - perNote.time!) * 100).toInt()));

      currentIndex++;
    }
    return currentIndex;
  }

  Future<void> wrongPlay(WidgetRef ref) async {
    state!.playMidiNote(
      velocity: 599,
      midi: 80,
    );
  }
}

class MelodyNotifier extends StateNotifier<Melody?> {
  MelodyNotifier(Melody? state) : super(null);

  Future<List<Melody?>> getMelodyList(WidgetRef ref) async {
    List<Melody?> currentMelodyList = [];

    final snapshot = await FirebaseCollectionEnums.melodies.reference.get();

    for (var document in snapshot.docs) {
      var melody = Melody.fromJson(document.data() as Map<String, dynamic>);

      currentMelodyList.add(melody);
    }

    return currentMelodyList;
  }

  Future<void> getMelodyAndSet(WidgetRef ref, String docId) async {
    final melody = await FirebaseCollectionEnums.melodies.reference
        .withConverter<Melody?>(
            fromFirestore: (snapshot, options) =>
                Melody.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value!.toJson())
        .doc(docId)
        .get();

    state = melody.data()!;

    /*for (int i = 0; i < state!.notes!.length; i++) {
      var perNote = state!.notes![i];

      Note? nextNote;

      if (i != melody.data()!.notes!.length - 1) {
        nextNote = state!.notes![i + 1];
      }

      perNote.name;


      play(ref, perNote);

      await Future.delayed(Duration(
          milliseconds:
          (((nextNote?.time ?? 0) - perNote.time!) * 1000).toInt()));
    }*/
  }
}
