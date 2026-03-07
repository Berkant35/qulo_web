import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/l10n/l10n.dart';
import '../../../providers/quiz_provider.dart';

class PowerBar extends ConsumerWidget {
  final String sessionId;
  final bool hasHint;

  const PowerBar({super.key, required this.sessionId, this.hasHint = false});

  static const _powers = [
    ('COPY', Icons.copy, 'power_copy'),
    ('HALF', Icons.call_split, 'power_half'),
    ('SKIP', Icons.skip_next, 'power_skip'),
    ('HINT', Icons.lightbulb_outline, 'power_hint'),
    ('TIME_EXTEND', Icons.timer, 'power_time'),
    ('SKIP_ALL', Icons.fast_forward, 'power_skip_all'),
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
              avatar: Icon(p.$2, size: 18, color: AppColors.purpleDark),
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
