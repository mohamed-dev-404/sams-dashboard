enum UserRole {
  admin('Admin'),
  instructor('instructor'),
  student('Student')
  ;

  final String label;
  const UserRole(this.label);

  //* Helper to extract Role from API response string
  static UserRole fromString(String role) {
    return UserRole.values.firstWhere(
      (e) => e.name.toLowerCase() == role.toLowerCase(),
      orElse: () => UserRole.student, // Default value when no match is found
    );
  }
}
