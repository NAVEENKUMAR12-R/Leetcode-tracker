class Countmodel {
  String? Student_name;
  String? Leetcode_id;
  int? count;
  double? ratings;

  Countmodel({
    required this.Student_name,
    required this.Leetcode_id,
    required this.count,
    required this.ratings,
  });

  // Sorted list based on ratings (descending)
  static List<Countmodel> Countlist() {
    List<Countmodel> list = [
      Countmodel(
        Student_name: 'Naveenkumar R',
        Leetcode_id: 'Naveen-1212',
        count: 5,
        ratings: 1748,
      ),
      Countmodel(
        Student_name: 'Kathirvel R',
        Leetcode_id: 'Naveen-1212',
        count: 5,
        ratings: 1748,
      ),
      Countmodel(
        Student_name: 'Naveen R',
        Leetcode_id: 'Naveen-1212',
        count: 5,
        ratings: 1749,
      ),
Countmodel(
        Student_name: 'Dineshram R',
        Leetcode_id: 'Dineshram_005',
        count: 5,
        ratings: 1806,
      ),
    ];

    list.sort((a, b) => (b.ratings ?? 0).compareTo(a.ratings ?? 0));
    return list;
  }
}
