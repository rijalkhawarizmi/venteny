import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart run generate_new_folder.dart feature_name');
    return;
  }
  final convert=pascalToSnakeCase(arguments[0]);
  final featureName = convert;
  final basePath = Directory.current.path;
  final featurePath = '$basePath/lib/src/$featureName';

  // Daftar folder dan file yang akan dibuat
  final foldersAndFiles = {
    'data/datasources': [
      '${featureName}_remote_data_source.dart',
    ],
    'data/models': [
      '${featureName}_model.dart',
    ],
    'data/repositories': [
      '${featureName}_repository_implementation.dart',
    ],
    'domain/entities': [
      '${featureName}_entity.dart',
    ],
    'domain/repositories': [
      '${featureName}_repository.dart',
    ],
    'domain/usecases': [
      '${featureName}_usecase.dart',
    ],
    'presentation/bloc': [],
    'presentation/pages': [
      '${featureName}_page.dart',
    ],
    'presentation/widgets': [],
  };

  for (var entry in foldersAndFiles.entries) {
    final folderName = entry.key;
    final folderPath = '$featurePath/$folderName';

    // Buat folder jika belum ada
    final dir = Directory(folderPath);
    if(dir.existsSync()){
      print('NAMA UNTUK FOLDER INI SUDAH ADA 🙁, GUNAKAN NAMA YANG LAIN ');
      return;
    }
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      print('Folder ${dir.path} berhasil dibuat.');
    }
    // Buat file dengan boilerplate
    for (var fileName in entry.value) {
      final filePath = '$folderPath/$fileName';
      final file = File(filePath);
      if (!file.existsSync()) {
        file.writeAsStringSync(_getBoilerplateContent(folderName, featureName));
        print('File $filePath berhasil dibuat.');
      } else {
        print('File $filePath sudah ada.');
      }
    }
  }

  print('STRUKTUR FOLDER "$featureName" SUDAH SELESAI DIBUAT 🤘😎');
}

/// Fungsi untuk mendapatkan boilerplate kode sesuai folder
String _getBoilerplateContent(String folder, String featureName) {
  switch (folder) {
    case 'data/datasources':
      return '''
import 'package:bursainvestasidigital/core/config/api_services.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/${_capitalize(featureName).toLowerCase()}_model.dart';


abstract class ${_convertToPascalCase(_capitalize(featureName))}RemoteDataSource {

  Future<${_convertToPascalCase(_capitalize(featureName))}Model> yourFunctionName();
 
}

class ${_convertToPascalCase(_capitalize(featureName))}RemoteDataSrcImpl implements ${_convertToPascalCase(_capitalize(featureName))}RemoteDataSource {
  // TODO: Implement ${_convertToPascalCase(_capitalize(featureName))}RemoteDataSource

  ${_convertToPascalCase(_capitalize(featureName))}RemoteDataSrcImpl(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<${_convertToPascalCase(_capitalize(featureName))}Model> yourFunctionName() async{
    try {
      final response = await _apiServices.getRequest(
        path: "your url",
      );
      if (response.statusCode == 200) {
        return ${_convertToPascalCase(_capitalize(featureName))}Model();
      }
      throw ApiException(message: response.data["message"]);
    } on DioException catch (e) {
      throw ApiException(message: e.message!);
    }
  }
}

''';
    case 'data/models':
      return '''
import 'package:bursainvestasidigital/src/${_capitalize(featureName).toLowerCase()}/domain/entities/${_capitalize(featureName).toLowerCase()}_entity.dart';

class ${_convertToPascalCase(_capitalize(featureName))}Model extends  ${_convertToPascalCase(_capitalize(featureName))}Entity {

  // TODO: Implement ${_convertToPascalCase(_capitalize(featureName))}Model

}
''';
    case 'data/repositories':
      return '''

import 'package:bursainvestasidigital/core/utils/typedef.dart';
import 'package:bursainvestasidigital/src/${_capitalize(featureName).toLowerCase()}/domain/entities/${_capitalize(featureName).toLowerCase()}_entity.dart';
import '../../domain/repositories/${_capitalize(featureName).toLowerCase()}_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/${_capitalize(featureName).toLowerCase()}_remote_data_source.dart';

class ${_convertToPascalCase(_capitalize(featureName))}RepositoryImplementation extends ${_convertToPascalCase(_capitalize(featureName))}Repository {
  ${_convertToPascalCase(_capitalize(featureName))}RepositoryImplementation(this._${_capitalize(featureName).toLowerCase()}RemoteDataSource);

  final ${_convertToPascalCase(_capitalize(featureName))}RemoteDataSource _${_capitalize(featureName).toLowerCase()}RemoteDataSource; 

  @override
  ResultFuture<${_convertToPascalCase(_capitalize(featureName))}Entity> yourFunctionName() async {
    // TODO: implement yourFunctionName
    try {
      ${_convertToPascalCase(_capitalize(featureName))}Entity ${_capitalize(featureName).toLowerCase()}Entity = await _${_capitalize(featureName).toLowerCase()}RemoteDataSource.yourFunctionName();
      return Right(${_capitalize(featureName).toLowerCase()}Entity);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
 
}

''';
    case 'domain/entities':
      return '''
import 'package:equatable/equatable.dart';

class ${_convertToPascalCase(_capitalize(featureName))}Entity extends Equatable {

  @override
  // TODO: implement props
  List<Object?> get props => [];
  // TODO: Define ${_convertToPascalCase(_capitalize(featureName))}Entity properties
}
''';
    case 'domain/repositories':
      return '''
import 'package:bursainvestasidigital/core/utils/typedef.dart';
import 'package:bursainvestasidigital/src/${_capitalize(featureName).toLowerCase()}/domain/entities/${_capitalize(featureName).toLowerCase()}_entity.dart';

abstract class ${_convertToPascalCase(_capitalize(featureName))}Repository {
  // TODO: Define ${_convertToPascalCase(_capitalize(featureName))}Repository interface

 const ${_convertToPascalCase(_capitalize(featureName))}Repository();

 ResultFuture<${_convertToPascalCase(_capitalize(featureName))}Entity> yourFunctionName();

}
''';
    case 'domain/usecases':
      return '''
import 'package:bursainvestasidigital/core/usecase/usecase.dart';
import 'package:bursainvestasidigital/src/${_capitalize(featureName).toLowerCase()}/domain/entities/${_capitalize(featureName).toLowerCase()}_entity.dart';
import 'package:bursainvestasidigital/src/${_capitalize(featureName).toLowerCase()}/domain/repositories/${_capitalize(featureName).toLowerCase()}_repository.dart';
import '../../../../core/utils/typedef.dart';

class ${_convertToPascalCase(_capitalize(featureName))}Usecase extends UsecaseWithoutParams<void> {
  
const ${_convertToPascalCase(_capitalize(featureName))}Usecase(this._repository);

final ${_convertToPascalCase(_capitalize(featureName))}Repository _repository;

// TODO: Implement ${_convertToPascalCase(_capitalize(featureName))} usecase
  @override
  ResultFuture<${_convertToPascalCase(_capitalize(featureName))}Entity> call() {
    // TODO: implement call ${_convertToPascalCase(_capitalize(featureName))}
    
    return _repository.yourFunctionName();
    
  }
}
''';
    case 'presentation/bloc':
      break;
    case 'presentation/pages':
      return '''
import 'package:flutter/material.dart';

class ${_convertToPascalCase(_capitalize(featureName))}Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_convertToPascalCase(_capitalize(featureName))}'),
      ),
      body: Center(
        child: Text('${_convertToPascalCase(_capitalize(featureName))}'),
      ),
    );
  }
}
''';
    default:
      return '// TODO: Implement code for $folder';
  }
  return '';
}

String pascalToSnakeCase(String input) {
  // Replace uppercase letters with _ followed by the lowercase letter
  return input.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => '_${match.group(0)!.toLowerCase()}')
    .replaceFirst('_', ''); // Remove leading underscore if present
}


 String _convertToPascalCase(String str) {
  // Memisahkan string berdasarkan underscore dan mengubah setiap kata jadi kapital
  var words = str.split('_');
  
  // Mengubah setiap kata menjadi kapital dan menggabungkan kembali menjadi satu string
  var result = words.map((word) => 
    word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : ''
  ).join();

  return result[0].toUpperCase() + result.substring(1);
}

/// Helper untuk mengkapitalisasi nama
String _capitalize(String text) {
  return text[0].toUpperCase() + text.substring(1);
}
