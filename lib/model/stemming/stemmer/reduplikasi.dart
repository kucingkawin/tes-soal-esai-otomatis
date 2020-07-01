class Reduplikasi {

  List kamus;

  Reduplikasi(List kamus) {
    this.kamus = kamus;
  }

  String remove(String keyword) {
    // contoh: abu-abu, terang-terangan
    if (keyword.contains("-")) {
      String firstParticle = keyword.substring(0, keyword.indexOf("-"));
      String secondParticle = keyword.substring(keyword.indexOf("-") + 1);
      if (this.kamus.contains(secondParticle)) {
        keyword = secondParticle;
      } else if (this.kamus.contains(firstParticle)) {
        keyword = firstParticle;
      } else {
        keyword = secondParticle;
      }
    }
    return keyword;
  }

}