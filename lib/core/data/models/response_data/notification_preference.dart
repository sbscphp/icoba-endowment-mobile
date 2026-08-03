class NotificationPreference {
   bool? emailNotificationsEnabled;
   bool? pushNotificationsEnabled;

   NotificationPreference({
    this.emailNotificationsEnabled,
    this.pushNotificationsEnabled,
  });

  factory NotificationPreference.fromJson(Map<String, dynamic> json) {
    return NotificationPreference(
      emailNotificationsEnabled: json['email_notifications_enabled'] as bool?,
      pushNotificationsEnabled: json['push_notifications_enabled'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email_notifications_enabled': emailNotificationsEnabled,
      'push_notifications_enabled': pushNotificationsEnabled,
    };
  }

  NotificationPreference copyWith({
    bool? emailNotificationsEnabled,
    bool? pushNotificationsEnabled,
  }) {
    return NotificationPreference(
      emailNotificationsEnabled:
          emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
    );
  }

  @override
  String toString() =>
      'NotificationPreference(emailNotificationsEnabled: $emailNotificationsEnabled, pushNotificationsEnabled: $pushNotificationsEnabled)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NotificationPreference &&
        other.emailNotificationsEnabled == emailNotificationsEnabled &&
        other.pushNotificationsEnabled == pushNotificationsEnabled;
  }

  @override
  int get hashCode =>
      emailNotificationsEnabled.hashCode ^ pushNotificationsEnabled.hashCode;
}