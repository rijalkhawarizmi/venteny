// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venteny/core/utils/status_task.dart';
import 'package:venteny/core/utils/validation.dart';


void main() {
  

group("email test", (){
 test("test form validation email",
      () => {expect(Validation.validateEmail(""), "Email cannot be empty")});

  test("test form validation email not valid",
      () => {expect(Validation.validateEmail("rijal"), "email not valid")});

  test("test form validation email valid",
      () => {expect(Validation.validateEmail("rijal@gmail.com"), null)});
});

  
  group("password test", (){
    test(
      "test form validation password 8 characters",
      () => {
            expect(Validation.validatePassword(""), "Password cannot be empty")
          });
  test(
      "test form validation password not 8 characters",
      () => {
            expect(Validation.validatePassword("1234567"),
                "Password must 8 characters")
          });

  test("test form validation password 8 characters",
      () => {expect(Validation.validatePassword("12345678"), null)});
  });



  group("status test", (){
    test(
      "test status pending",
      () => {
            expect(StatusTask.statusTask(status: 1), "PENDING")
          });

      test(
      "test status in progress",
      () => {
            expect(StatusTask.statusTask(status: 2), "IN PROGRESS")
          });

       test(
      "test status in completed",
      () => {
            expect(StatusTask.statusTask(status: 3), "COMPLETED")
          });
  

  
  });



}
