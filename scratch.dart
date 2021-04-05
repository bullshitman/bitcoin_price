void main() {
  var bottleCount;
  for (int i = 99; i >= 1; i--) {
    print('$i bottles of beer on the wall, $i bottles of beer.');
    bottleCount = (i - 1) > 0 ? (i - 1) : 'no more';
    print(
        'Take one down and pass it around, $bottleCount bottles of beer on the wall.');
  }
  print('No more bottles of beer on the wall, no more bottles of beer.');
  print('Go to the store and buy some more, 99 bottles of beer on the wall.');
}
