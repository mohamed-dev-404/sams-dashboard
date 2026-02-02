import 'package:sams_dashboard/features/home/data/enum/user_role.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';
import 'package:sams_dashboard/features/home/data/models/user_model.dart';

List<UserModel> getMockUsers() {
  return [
    UserModel(
      id: '202202657',
      name: 'Yomna Abdelmegeed fathallah Abdelmegeed',
      email: '202202657@o6u.edu.eg',
      status: UserStatus.active,
      role: UserRole.student,
    ),
    UserModel(
      id: '202207000',
      name: 'Mohamed Ibrahim',
      email: '202207000@o6u.edu.eg',
      status: UserStatus.inactive,
      role: UserRole.teacher,
    ),
    UserModel(
      id: '202201576',
      name: 'Ahmed Osama Hassan Tawfik',
      email: '202201576@o6u.edu.eg',
      status: UserStatus.active,
      role: UserRole.student,
    ),
    UserModel(
      id: '202203195',
      name: 'Ahmed Refaat Abdelnaby',
      email: '202203195@o6u.edu.eg',
      status: UserStatus.active,
      role: UserRole.student,
    ),
    UserModel(
      id: '202202565',
      name: 'Ahmed Adel Ahmed Khalil',
      email: '202202565@o6u.edu.eg',
      status: UserStatus.inactive,
      role: UserRole.student,
    ),
    UserModel(
      id: '202203622',
      name: 'Ahmed Mohamed Maher Mohamed Rizk',
      email: '202203622@o6u.edu.eg',
      status: UserStatus.active,
      role: UserRole.student,
    ),
    UserModel(
      id: '202202131',
      name: 'Ahmed Nabil Mohamed Elzaeida',
      email: '202202131@o6u.edu.eg',
      status: UserStatus.active,
      role: UserRole.teacher,
    ),
    UserModel(
      id: '202203664',
      name: 'Ekhlas Sobhy Maghawry Maghawry',
      email: '202203664@o6u.edu.eg',
      status: UserStatus.active,
      role: UserRole.student,
    ),
    UserModel(
      id: '202202647',
      name: 'Adham Rahem Mohamed Nasr ElDin Saleh',
      email: '202202647@o6u.edu.eg',
      status: UserStatus.inactive,
      role: UserRole.student,
    ),
    UserModel(
      id: '202203100',
      name: 'Eshaa Neshat Mohamed Gadallah',
      email: '202203100@o6u.edu.eg',
      status: UserStatus.active,
      role: UserRole.student,
    ),
    UserModel(
      id: '202203888',
      name: 'Basmah Ahmed Mohamed ElSayed',
      email: '202203888@o6u.edu.eg',
      status: UserStatus.active,
      role: UserRole.student,
    ),
    UserModel(
      id: '202203490',
      name: 'Khaled Nasr Eldin Mohamed Moawad',
      email: '202203490@o6u.edu.eg',
      status: UserStatus.inactive,
      role: UserRole.teacher,
    ),
  ];
}
