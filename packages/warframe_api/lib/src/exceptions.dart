class ProfileNotFound implements Exception {
  const ProfileNotFound([this.message]);

  final dynamic message;

  @override
  String toString() => 'ProfileNotFound($message)';
}
