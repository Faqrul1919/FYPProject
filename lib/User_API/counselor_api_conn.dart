class Coun_API {
  static const hostConnect = "http://192.168.100.16/gmatedb";
  static const hostConnectStudent = "$hostConnect/counselor";

  static const register = "$hostConnect/counselor/c_register.php";
  static const validateEmail = "$hostConnect/counselor/validate.php";
  static const login = "$hostConnect/counselor/c_login.php";
  static const getReview = "$hostConnect/counselor/student_review.php";
  static const getStudent = "$hostConnect/counselor/viewstudent.php";
  static const updateCounProfile = "$hostConnect/counselor/update_profile.php";

  //favorite
  static const validateFavorite =
      "$hostConnect/counselor/validate_favorite.php";
  static const addFavorite = "$hostConnect/counselor/add.php";
  static const deleteFavorite = "$hostConnect/counselor/delete.php";
  static const readFavorite = "$hostConnect/counselor/read.php";

  static const readStudSubj = "$hostConnect/counselor/studentSubjectList.php";
}
