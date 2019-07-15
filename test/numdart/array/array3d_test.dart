import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a 3x3x3 matrix that represent a book', () {
    var book = Array3d();

    var page = Array2d();
    page.add([1.0 ,2.0 , 3.0]);
    page.add([1.0 ,2.0 , 3.0]);
    page.add([1.0 ,2.0 , 3.0]);
    
    book.add(page);
    book.add(page);
    book.add(page);
    
    int i = 0;
    expect(book[i].elementAt(0).elementAt(0), 1.0);
    expect(book[i].elementAt(0).elementAt(1), 2.0);
    expect(book[i].elementAt(0).elementAt(2), 3.0);

    i = 1;
    expect(book[i].elementAt(1).elementAt(0), 1.0);
    expect(book[i].elementAt(1).elementAt(1), 2.0);
    expect(book[i].elementAt(1).elementAt(2), 3.0);

    i = 2;
    expect(book[i].elementAt(2).elementAt(0), 1.0);
    expect(book[i].elementAt(2).elementAt(1), 2.0);
    expect(book[i].elementAt(2).elementAt(2), 3.0);
  });
}