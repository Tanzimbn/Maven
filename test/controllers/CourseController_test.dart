import 'package:flutter_application_1/controllers/CourseController.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late courseController course;

  setUp(() {
    course = courseController();
  });
  group('Course Controller', () {
    group('New rating', () { 
      test('Rating update', () {
        //Arrange
        //Act
        course.loadAllCourse();
        final temp = course.allCourse;
        //Assert
        expect(temp.length, 0);
      });
    });

  });
}