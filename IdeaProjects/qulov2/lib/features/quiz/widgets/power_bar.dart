import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/q_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/q_icon.dart';
import '../../../providers/quiz_provider.dart';

class PowerBar extends ConsumerWidget {
  final String sessionId;
  final bool hasHint;

  const PowerBar({super.key, required this.sessionId, this.hasHint = false});

  static const _powers = [
    ('COPY', QIcons.icCopy, 'power_copy'),
    ('HALF', QIcons.icSplit, 'power_half'),
    ('SKIP', QIcons.icSkipForward, 'power_skip'),
    ('HINT', QIcons.icLightbulb, 'power_hint'),
    ('TIME_EXTEND', QIcons.icClock, 'power_time'),
    ('SKIP_ALL', QIcons.icFastForward, 'power_skip_all'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _powers.map((p) {
          final isHint = p.$1 == 'HINT';
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: ActionChip(
              avatar: QIcon(p.$2, size: 18, color: AppColors.primaryDark),
              label: Text(context.tr(p.$3)),
              onPressed: (isHint && !hasHint)
                  ? null
                  : () => ref.read(quizProvider.notifier).answer(0, powerUsed: p.$1),
            ),
          );
        }).toList(),
      ),
    );
  }
}
