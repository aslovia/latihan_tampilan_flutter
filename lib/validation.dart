class Validation {
  String validatePassword(String password) {

    if (password.length < 6 ) {
      return 'Password diisi minimal 6 karakter';
    }
  }

  String validateEmail(String email) {
    if (!email.contains('@')) { //JIKA VALUE MENGANDUNG KARAKTER @
      return 'Email tidak valid'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }

  String validateName(String name) {
    if (name.isEmpty) { //JIKA VALUE KOSONG
      return 'Nama Lengkap Harus Diisi'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }
}
