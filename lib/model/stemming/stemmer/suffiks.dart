class Suffiks {
  List kamus;

  Suffiks(List kamus) {
    this.kamus = kamus;
  }

  String remove(String keyword) {
    return removeSuffixes(keyword);
  }

  String removeSuffixes(String keyword) {
    /*
       * Pertama cari kata yang akan diistem dalam kamus kata dasar.
       * Jika ditemukan maka diasumsikan kata adalah root keyword.
       * Maka algoritma berhenti.
    */
    if (!this.kamus.contains(keyword)) {
      keyword = this.removePossesive(keyword);
    }
    if (!this.kamus.contains(keyword)) {
      keyword = this.removeDerivation(keyword);
    }
    return keyword;
  }

  String removePossesive(String keyword) {
    /*
       * Inflection Suffixes (“-lah”, “-kah”, “-ku”, “-mu”, atau “-nya”) dibuang.
       * Jika berupa particles (“-lah”, “-kah”, “-tah” atau “-pun”) maka langkah ini diulangi lagi untuk
       * menghapus Possesive Pronouns (“-ku”, “-mu”, atau “-nya”), jika ada.
    */
    if (keyword.endsWith("lah")) {
      keyword = keyword.substring(0, keyword.length - 3);
    } else if (keyword.endsWith("kah")) {
      keyword = keyword.substring(0, keyword.length - 3);
    } else if (keyword.endsWith("ku")) {
      keyword = keyword.substring(0, keyword.length - 2);
    } else if (keyword.endsWith("mu")) {
      keyword = keyword.substring(0, keyword.length - 2);
    } else if (keyword.endsWith("nya")) {
      keyword = keyword.substring(0, keyword.length - 3);
    }
    return keyword;
  }

  String removeDerivation(String keyword) {
    /*langkah 3
       * Hapus Derivation Suffixes (“-i”, “-an” atau “-kan”).
       * Jika kata ditemukan di kamus, maka algoritma berhenti.
       * Jika tidak maka ke langkah 3a
       * 3a.  Jika “-an” telah dihapus dan huruf terakhir dari kata tersebut adalah “-k”, maka “-k” juga ikut dihapus.
       *      Jika kata tersebut ditemukan dalam kamus maka algoritma berhenti. Jika tidak ditemukan maka lakukan langkah.
       * 3b.  Akhiran yang dihapus (“-i”, “-an” atau “-kan”) dikembalikan, lanjut ke langkah 4.
     */
    if (keyword.endsWith("i")) {
      keyword = keyword.substring(0, keyword.length - 1);
    } else if (keyword.endsWith("kan")) {
      keyword = keyword.substring(0, keyword.length - 3);
    } else if (keyword.endsWith("an")) {
      keyword = keyword.substring(0, keyword.length - 2);
    }
    return keyword;
  }
}