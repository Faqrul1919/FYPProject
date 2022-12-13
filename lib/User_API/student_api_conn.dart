class API {
  static const hostConnect = "http://192.168.100.16/gmatedb";
  static const hostConnectStudent = "$hostConnect/student";

  static const register = "$hostConnect/student/register.php";
  static const validateEmail = "$hostConnect/student/validate.php";
  static const login = "$hostConnect/student/login.php";
  static const updateprofile = "$hostConnect/student/update_profile.php";
  static const getReview = "$hostConnect/student/student_review.php";
  static const ratingAuth = "$hostConnect/student/rating_code_auth.php";

  //addsubj & group
  static const validateSubject = "$hostConnect/student/validate_subject.php";
  static const addSubject = "$hostConnect/student/add.php";
  static const deleteSubject = "$hostConnect/student/delete.php";
  static const readSubject = "$hostConnect/student/read.php";

  static const addRatingReview = "$hostConnect/student/add_review.php";

  static const studRegisteredSubject =
      "$hostConnect/student/readStudentRegistered.php";

  //favorite
  static const validateFavorite = "$hostConnect/student/validate_favorite.php";
  static const addFavorite = "$hostConnect/student/add_favourite.php";
  static const deleteFavorite = "$hostConnect/student/delete_favourite.php";
  static const readFavorite = "$hostConnect/student/read_favourite.php";
}
