part of 'personal_info.dart';

mixin PersonalInfoMixin on ConsumerState<PersonalInfoHeader> {
  Future<Map<String,int>> countOfMeetings() async {
    int v1 = 0;
    int v2 = 0;
    final ftrList = <Future>[
     ref.read(currentSelectMeetState.notifier).getMeetCount(ref),
      get7dayMeetingCount()
    ];

    await Future.wait(ftrList).then((value){
      v1 = value.first;
      v2 = value[1];
    });

    return {
      "totalMeetCount" : v1,
      "totalLast7Days": v2
    };
  }


  Future<int> totalDurationTime() async => await ref
      .read(currentSelectMeetState.notifier)
      .getSumDurationOfMeetings(ref);

  Future<int> get7dayMeetingCount() async => await ref.read(currentSelectMeetState.notifier).getLast7daysMeetCount(ref);
}
