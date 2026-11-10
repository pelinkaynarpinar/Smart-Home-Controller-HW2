/// Mixin: adds a simple scheduling property and behavior to a device.
/// This demo stores the planned time; it does not run a background task.
mixin Schedulable {
  DateTime? scheduledAt;

  void scheduleFor(DateTime time) {
    scheduledAt = time;
  }

  void clearSchedule() {
    scheduledAt = null;
  }
}
