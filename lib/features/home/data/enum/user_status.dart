enum UserStatus {
  active('Active'),
  inactive('Inactive')
  ;

  final String label;
  const UserStatus(this.label);
}
