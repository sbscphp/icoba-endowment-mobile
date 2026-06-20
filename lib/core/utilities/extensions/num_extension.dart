extension Range on num {
  bool isBetween(int from, int to) {
    return from <= this && this <= to;
  }
}