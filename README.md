# venteny



EMAIL LOGIN => eve.holt@reqres.in
PASSWORD => cityslicka

Metode yang digunakan yaitu DOMAIN DRIVE DESIGN
arsitekturnya seperti berikut

FOLDER DATA
Models -> Representasi data yang bisa dikonversi dari/ke JSON.
Data Sources -> Menghubungkan ke API atau database.
Repositories -> Implementasi dari abstraksi di domain 

FOLDER DOMAIN
Entities -> Objek utama dalam domain bisnis.
Repositories -> Abstraksi untuk pengambilan data.
Use Cases -> Logika bisnis spesifik.

FOLDER PRESENTATION
Pages -> Halaman atau tampilan aplikasi.
Widgets -> kumpulan widget.
State management -> Bloc,provider dll.


BONUS PEGERJANN
LOCAL NOTIICATION,MUNCUL 5 MENIT SEBELUM WAKTU YANG DIBUAT DAN DARKMODE JUGA SUDAH DITAMBAHKAN


PACKAGE YANG DIGUNAKAN
 pretty_dio_logger: ^1.4.0
  flutter_bloc: ^9.1.0
  dartz: ^0.10.1
  get_it: ^8.0.3
  dio: ^5.8.0+1
  equatable: ^2.0.7
  sqflite: ^2.4.1
  connectivity_plus: ^6.1.0
  flutter_svg: ^2.0.17
  go_router: ^14.8.1
  intl: ^0.20.2
  flutter_local_notifications: ^17.0.0
  flutter_timezone: ^1.0.8