import 'package:audiotodo/generated/l10n.dart';

enum ProblemType {
  featureRequest,
  bugReport,
  accountIssue,
  paymentIssue,
  other;

  String get title {
    switch (this) {
      case ProblemType.featureRequest:
        return S.current.contact_us_feature_request;
      case ProblemType.bugReport:
        return S.current.contact_us_bug_report;
      case ProblemType.accountIssue:
        return S.current.contact_us_account_issue;
      case ProblemType.paymentIssue:
        return S.current.contact_us_payment_issue;
      case ProblemType.other:
        return S.current.contact_us_other;
    }
  }
}
