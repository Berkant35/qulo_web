// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'click_up_space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClickUpSpaceImpl _$$ClickUpSpaceImplFromJson(Map<String, dynamic> json) =>
    _$ClickUpSpaceImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      private: json['private'] as bool?,
      avatar: json['avatar'] as String?,
      adminCanManage: json['admin_can_manage'] as bool?,
      statuses: (json['statuses'] as List<dynamic>?)
          ?.map((e) => Statuses.fromJson(e as Map<String, dynamic>))
          .toList(),
      multipleAssignees: json['multiple_assignees'] as bool?,
      features: json['features'] == null
          ? null
          : Features.fromJson(json['features'] as Map<String, dynamic>),
      archived: json['archived'] as bool?,
    );

Map<String, dynamic> _$$ClickUpSpaceImplToJson(_$ClickUpSpaceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'private': instance.private,
      'avatar': instance.avatar,
      'admin_can_manage': instance.adminCanManage,
      'statuses': instance.statuses?.map((e) => e.toJson()).toList(),
      'multiple_assignees': instance.multipleAssignees,
      'features': instance.features?.toJson(),
      'archived': instance.archived,
    };

_$StatusesImpl _$$StatusesImplFromJson(Map<String, dynamic> json) =>
    _$StatusesImpl(
      id: json['id'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      orderindex: (json['orderindex'] as num?)?.toInt(),
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$StatusesImplToJson(_$StatusesImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'type': instance.type,
      'orderindex': instance.orderindex,
      'color': instance.color,
    };

_$FeaturesImpl _$$FeaturesImplFromJson(Map<String, dynamic> json) =>
    _$FeaturesImpl(
      dueDates: json['due_dates'] == null
          ? null
          : DueDates.fromJson(json['due_dates'] as Map<String, dynamic>),
      sprints: json['sprints'] == null
          ? null
          : Sprints.fromJson(json['sprints'] as Map<String, dynamic>),
      timeTracking: json['time_tracking'] == null
          ? null
          : TimeTracking.fromJson(
              json['time_tracking'] as Map<String, dynamic>),
      points: json['points'] == null
          ? null
          : Points.fromJson(json['points'] as Map<String, dynamic>),
      customItems: json['custom_items'] == null
          ? null
          : CustomItems.fromJson(json['custom_items'] as Map<String, dynamic>),
      priorities: json['priorities'] == null
          ? null
          : Priorities.fromJson(json['priorities'] as Map<String, dynamic>),
      tags: json['tags'] == null
          ? null
          : Tags.fromJson(json['tags'] as Map<String, dynamic>),
      checkUnresolved: json['check_unresolved'] == null
          ? null
          : CheckUnresolved.fromJson(
              json['check_unresolved'] as Map<String, dynamic>),
      zoom: json['zoom'] == null
          ? null
          : Zoom.fromJson(json['zoom'] as Map<String, dynamic>),
      milestones: json['milestones'] == null
          ? null
          : Milestones.fromJson(json['milestones'] as Map<String, dynamic>),
      customFields: json['custom_fields'] == null
          ? null
          : CustomFields.fromJson(
              json['custom_fields'] as Map<String, dynamic>),
      dependencyWarning: json['dependency_warning'] == null
          ? null
          : DependencyWarning.fromJson(
              json['dependency_warning'] as Map<String, dynamic>),
      statusPies: json['status_pies'] == null
          ? null
          : StatusPies.fromJson(json['status_pies'] as Map<String, dynamic>),
      multipleAssignees: json['multiple_assignees'] == null
          ? null
          : MultipleAssignees.fromJson(
              json['multiple_assignees'] as Map<String, dynamic>),
      emails: json['emails'] == null
          ? null
          : Emails.fromJson(json['emails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FeaturesImplToJson(_$FeaturesImpl instance) =>
    <String, dynamic>{
      'due_dates': instance.dueDates?.toJson(),
      'sprints': instance.sprints?.toJson(),
      'time_tracking': instance.timeTracking?.toJson(),
      'points': instance.points?.toJson(),
      'custom_items': instance.customItems?.toJson(),
      'priorities': instance.priorities?.toJson(),
      'tags': instance.tags?.toJson(),
      'check_unresolved': instance.checkUnresolved?.toJson(),
      'zoom': instance.zoom?.toJson(),
      'milestones': instance.milestones?.toJson(),
      'custom_fields': instance.customFields?.toJson(),
      'dependency_warning': instance.dependencyWarning?.toJson(),
      'status_pies': instance.statusPies?.toJson(),
      'multiple_assignees': instance.multipleAssignees?.toJson(),
      'emails': instance.emails?.toJson(),
    };

_$DueDatesImpl _$$DueDatesImplFromJson(Map<String, dynamic> json) =>
    _$DueDatesImpl(
      enabled: json['enabled'] as bool?,
      startDate: json['start_date'] as bool?,
      remapDueDates: json['remap_due_dates'] as bool?,
      remapClosedDueDate: json['remap_closed_due_date'] as bool?,
    );

Map<String, dynamic> _$$DueDatesImplToJson(_$DueDatesImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'start_date': instance.startDate,
      'remap_due_dates': instance.remapDueDates,
      'remap_closed_due_date': instance.remapClosedDueDate,
    };

_$SprintsImpl _$$SprintsImplFromJson(Map<String, dynamic> json) =>
    _$SprintsImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$SprintsImplToJson(_$SprintsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$TimeTrackingImpl _$$TimeTrackingImplFromJson(Map<String, dynamic> json) =>
    _$TimeTrackingImpl(
      enabled: json['enabled'] as bool?,
      harvest: json['harvest'] as bool?,
      rollup: json['rollup'] as bool?,
    );

Map<String, dynamic> _$$TimeTrackingImplToJson(_$TimeTrackingImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'harvest': instance.harvest,
      'rollup': instance.rollup,
    };

_$PointsImpl _$$PointsImplFromJson(Map<String, dynamic> json) => _$PointsImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$PointsImplToJson(_$PointsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$CustomItemsImpl _$$CustomItemsImplFromJson(Map<String, dynamic> json) =>
    _$CustomItemsImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$CustomItemsImplToJson(_$CustomItemsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$PrioritiesImpl _$$PrioritiesImplFromJson(Map<String, dynamic> json) =>
    _$PrioritiesImpl(
      enabled: json['enabled'] as bool?,
      priorities: (json['priorities'] as List<dynamic>?)
          ?.map((e) => Priorities.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PrioritiesImplToJson(_$PrioritiesImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'priorities': instance.priorities?.map((e) => e.toJson()).toList(),
    };

_$SubPrioritiesImpl _$$SubPrioritiesImplFromJson(Map<String, dynamic> json) =>
    _$SubPrioritiesImpl(
      color: json['color'] as String?,
      id: json['id'] as String?,
      orderindex: json['orderindex'] as String?,
      priority: json['priority'] as String?,
    );

Map<String, dynamic> _$$SubPrioritiesImplToJson(_$SubPrioritiesImpl instance) =>
    <String, dynamic>{
      'color': instance.color,
      'id': instance.id,
      'orderindex': instance.orderindex,
      'priority': instance.priority,
    };

_$TagsImpl _$$TagsImplFromJson(Map<String, dynamic> json) => _$TagsImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$TagsImplToJson(_$TagsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$CheckUnresolvedImpl _$$CheckUnresolvedImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckUnresolvedImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$CheckUnresolvedImplToJson(
        _$CheckUnresolvedImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$ZoomImpl _$$ZoomImplFromJson(Map<String, dynamic> json) => _$ZoomImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$ZoomImplToJson(_$ZoomImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$MilestonesImpl _$$MilestonesImplFromJson(Map<String, dynamic> json) =>
    _$MilestonesImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$MilestonesImplToJson(_$MilestonesImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$CustomFieldsImpl _$$CustomFieldsImplFromJson(Map<String, dynamic> json) =>
    _$CustomFieldsImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$CustomFieldsImplToJson(_$CustomFieldsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$DependencyWarningImpl _$$DependencyWarningImplFromJson(
        Map<String, dynamic> json) =>
    _$DependencyWarningImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$DependencyWarningImplToJson(
        _$DependencyWarningImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$StatusPiesImpl _$$StatusPiesImplFromJson(Map<String, dynamic> json) =>
    _$StatusPiesImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$StatusPiesImplToJson(_$StatusPiesImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$MultipleAssigneesImpl _$$MultipleAssigneesImplFromJson(
        Map<String, dynamic> json) =>
    _$MultipleAssigneesImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$MultipleAssigneesImplToJson(
        _$MultipleAssigneesImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };

_$EmailsImpl _$$EmailsImplFromJson(Map<String, dynamic> json) => _$EmailsImpl(
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$EmailsImplToJson(_$EmailsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };
