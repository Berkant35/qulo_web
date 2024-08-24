import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/meet/meet_model.dart';
import '../../../../utilities/components/cards/list_card.dart';
import '../../../../utilities/constants/extensions/time_extension.dart';

class MeetList extends ConsumerStatefulWidget {
  const MeetList({super.key});

  @override
  ConsumerState createState() => _MeetListState();
}

class _MeetListState extends ConsumerState<MeetList> {
  final ScrollController _scrollController = ScrollController();
  final List<Meet> _meets = [];
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadMoreMeets();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _loadMoreMeets();
      }
    });
  }



  Future<void> _loadMoreMeets() async {
    setState(() {
      _isLoading = true;
    });

    final List<Meet> newMeets = await ref.read(currentSelectMeetState.notifier)
        .getMeetList(ref, lastMeet: _meets.isNotEmpty ? _meets.last : null);

    setState(() {
      _isLoading = false;
      if (newMeets.length < 20) {
        _hasMore = false;
      }
      _meets.addAll(newMeets);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _meets.length + 1,
      padding: EdgeInsets.only(bottom: 9.h),
      itemBuilder: (context, index) {
        if (index == _meets.length) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink();
        }

        return ListCard(
          showFab: false,
          isDone: false,
          donePressed: () async {},
          onPressed: () async => await goToMeetOfDetail(index).then((value) => setState(() {})),
          customTitle: _meets[index].meetTitle ?? '',
          subtitleText: _meets[index].meetSubtitle ?? '',
          date: _meets[index].createdAt?.fromddMMyyyyHHmmToDateTime,
        );
      },
    );
  }

  Future<void> goToMeetOfDetail(int index) async {
    ref.read(currentMeetControllerManager.notifier)
        .changeCurrentMeetState(_meets[index]);
    ref.read(currentPlayerManagerState.notifier)
        .initializePlayerFromStorageController(ref);

    await NavigationService.instance
        .navigateToPage(path: NavigationConstants.meetDetailBase).then((value) {
      // Sayfa geri döndüğünde tüm listeyi yeniden yükleyin
      _meets.clear();
      _hasMore = true; // Eğer daha fazla veri varsa onları da çekebilmesi için
      _loadMoreMeets().then((value) {
        setState(() {});
      });
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
