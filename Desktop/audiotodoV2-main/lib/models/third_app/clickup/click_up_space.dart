import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'click_up_space.freezed.dart';
part 'click_up_space.g.dart';

@freezed
class ClickUpSpace with _$ClickUpSpace {
  const factory ClickUpSpace({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'private') bool? private,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'admin_can_manage') bool? adminCanManage,
    @JsonKey(name: 'statuses') List<Statuses>? statuses,
    @JsonKey(name: 'multiple_assignees') bool? multipleAssignees,
    @JsonKey(name: 'features') Features? features,
    @JsonKey(name: 'archived') bool? archived,
  }) = _ClickUpSpace;

  factory ClickUpSpace.fromJson(Map<String, Object?> json) =>
      _$ClickUpSpaceFromJson(json);
}

@freezed
class Statuses with _$Statuses {
  const factory Statuses({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'orderindex') int? orderindex,
    @JsonKey(name: 'color') String? color,
  }) = _Statuses;

  factory Statuses.fromJson(Map<String, Object?> json) =>
      _$StatusesFromJson(json);
}

@freezed
class Features with _$Features {
  const factory Features({
    @JsonKey(name: 'due_dates') DueDates? dueDates,
    @JsonKey(name: 'sprints') Sprints? sprints,
    @JsonKey(name: 'time_tracking') TimeTracking? timeTracking,
    @JsonKey(name: 'points') Points? points,
    @JsonKey(name: 'custom_items') CustomItems? customItems,
    @JsonKey(name: 'priorities') Priorities? priorities,
    @JsonKey(name: 'tags') Tags? tags,
    @JsonKey(name: 'check_unresolved') CheckUnresolved? checkUnresolved,
    @JsonKey(name: 'zoom') Zoom? zoom,
    @JsonKey(name: 'milestones') Milestones? milestones,
    @JsonKey(name: 'custom_fields') CustomFields? customFields,
    @JsonKey(name: 'dependency_warning') DependencyWarning? dependencyWarning,
    @JsonKey(name: 'status_pies') StatusPies? statusPies,
    @JsonKey(name: 'multiple_assignees') MultipleAssignees? multipleAssignees,
    @JsonKey(name: 'emails') Emails? emails,
  }) = _Features;

  factory Features.fromJson(Map<String, Object?> json) =>
      _$FeaturesFromJson(json);
}

@freezed
class DueDates with _$DueDates {
  const factory DueDates({
    @JsonKey(name: 'enabled') bool? enabled,
    @JsonKey(name: 'start_date') bool? startDate,
    @JsonKey(name: 'remap_due_dates') bool? remapDueDates,
    @JsonKey(name: 'remap_closed_due_date') bool? remapClosedDueDate,
  }) = _DueDates;

  factory DueDates.fromJson(Map<String, Object?> json) =>
      _$DueDatesFromJson(json);
}

@freezed
class Sprints with _$Sprints {
  const factory Sprints({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _Sprints;

  factory Sprints.fromJson(Map<String, Object?> json) =>
      _$SprintsFromJson(json);
}

@freezed
class TimeTracking with _$TimeTracking {
  const factory TimeTracking({
    @JsonKey(name: 'enabled') bool? enabled,
    @JsonKey(name: 'harvest') bool? harvest,
    @JsonKey(name: 'rollup') bool? rollup,
  }) = _TimeTracking;

  factory TimeTracking.fromJson(Map<String, Object?> json) =>
      _$TimeTrackingFromJson(json);
}

@freezed
class Points with _$Points {
  const factory Points({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _Points;

  factory Points.fromJson(Map<String, Object?> json) => _$PointsFromJson(json);
}

@freezed
class CustomItems with _$CustomItems {
  const factory CustomItems({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _CustomItems;

  factory CustomItems.fromJson(Map<String, Object?> json) =>
      _$CustomItemsFromJson(json);
}

@freezed
class Priorities with _$Priorities {
  const factory Priorities({
    @JsonKey(name: 'enabled') bool? enabled,
    @JsonKey(name: 'priorities') List<Priorities>? priorities,
  }) = _Priorities;

  factory Priorities.fromJson(Map<String, Object?> json) =>
      _$PrioritiesFromJson(json);
}

@freezed
class SubPriorities with _$SubPriorities {
  const factory SubPriorities({
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'orderindex') String? orderindex,
    @JsonKey(name: 'priority') String? priority,
  }) = _SubPriorities;

  factory SubPriorities.fromJson(Map<String, Object?> json) =>
      _$SubPrioritiesFromJson(json);
}

@freezed
class Tags with _$Tags {
  const factory Tags({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _Tags;

  factory Tags.fromJson(Map<String, Object?> json) => _$TagsFromJson(json);
}

@freezed
class CheckUnresolved with _$CheckUnresolved {
  const factory CheckUnresolved({
    @JsonKey(name: 'enabled') bool? enabled,

  }) = _CheckUnresolved;

  factory CheckUnresolved.fromJson(Map<String, Object?> json) =>
      _$CheckUnresolvedFromJson(json);
}

@freezed
class Zoom with _$Zoom {
  const factory Zoom({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _Zoom;

  factory Zoom.fromJson(Map<String, Object?> json) => _$ZoomFromJson(json);
}

@freezed
class Milestones with _$Milestones {
  const factory Milestones({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _Milestones;

  factory Milestones.fromJson(Map<String, Object?> json) =>
      _$MilestonesFromJson(json);
}

@freezed
class CustomFields with _$CustomFields {
  const factory CustomFields({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _CustomFields;

  factory CustomFields.fromJson(Map<String, Object?> json) =>
      _$CustomFieldsFromJson(json);
}

@freezed
class DependencyWarning with _$DependencyWarning {
  const factory DependencyWarning({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _DependencyWarning;

  factory DependencyWarning.fromJson(Map<String, Object?> json) =>
      _$DependencyWarningFromJson(json);
}

@freezed
class StatusPies with _$StatusPies {
  const factory StatusPies({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _StatusPies;

  factory StatusPies.fromJson(Map<String, Object?> json) =>
      _$StatusPiesFromJson(json);
}

@freezed
class MultipleAssignees with _$MultipleAssignees {
  const factory MultipleAssignees({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _MultipleAssignees;

  factory MultipleAssignees.fromJson(Map<String, Object?> json) =>
      _$MultipleAssigneesFromJson(json);
}

@freezed
class Emails with _$Emails {
  const factory Emails({
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _Emails;

  factory Emails.fromJson(Map<String, Object?> json) => _$EmailsFromJson(json);
}
