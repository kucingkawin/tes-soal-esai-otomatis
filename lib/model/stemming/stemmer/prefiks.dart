import 'package:tessoal/model/RegExpFlex.dart';

class Prefiks {
  List kamus;

  Prefix(List kamus) {
    this.kamus = kamus;
  }

  String remove(String keyword) {
    return removeDerivation(keyword);
  }

  String removeDerivation(String keyword) {
    RegExpFlex regExpFlex = RegExpFlex();

    if (!this.kamus.contains(keyword)) {
      if (keyword.startsWith("di")) {
        keyword = keyword.substring(2);
      } else if (keyword.startsWith("ke")) {
        keyword = keyword.substring(2);
      } else if (keyword.startsWith("se")) {
        keyword = keyword.substring(2);
      }
    }
    if (!this.kamus.contains(keyword)) {
      // Penghapuskan kata awalan me-, te-, be-
      if (keyword.startsWith("me")) {
        if (keyword.startsWith("meng")) {
          if (keyword.contains("k" + keyword.substring(4))) {
            keyword = "k" + keyword.substring(4);
          } else if (regExpFlex.setPattern("[gh]").hasMatch(keyword.substring(4, 5))) {
            keyword = keyword.substring(4);
          }
        } else if (keyword.startsWith("meny")) {
          if (keyword.contains("s" + keyword.substring(4))) {
            keyword = "k" + keyword.substring(4);
          }
        } else if (keyword.startsWith("mem")) {
          if (regExpFlex.setPattern("[bpf]").hasMatch(keyword.substring(3, 4))) {
            keyword = keyword.substring(3);
          }
        } else if (keyword.startsWith("men")) {
          if (regExpFlex.setPattern("[cdj]").hasMatch(keyword.substring(3, 4))) {
            keyword = keyword.substring(3);
          } else if (keyword.contains("t" + keyword.substring(3))) {
            keyword = "k" + keyword.substring(3);
          }
        } else {
          keyword = keyword.substring(2);
        }

      } else if (keyword.startsWith("te")) {
        if (keyword.startsWith("ter")) {
          if (keyword.contains("r" + keyword.substring(3))) {
            keyword = "r" + keyword.substring(3);
          } else {
            keyword = keyword.substring(3);
          }
        }
      } else if (keyword.startsWith("be")) {
        if (regExpFlex.setPattern("er").hasMatch(keyword.substring(3, 5))) {
          keyword = keyword.substring(2);
        } else if (keyword.contains(keyword.substring(2))) {
          keyword = keyword.substring(2);
        } else {
          keyword = keyword.substring(3);
        }
      }
    }

    //Pengahapuskan kata awalan pe-
    if (!this.kamus.contains(keyword)) {
      if (keyword.startsWith("pe")) {
        if (kamus.contains(keyword.substring(2))) {
          keyword = keyword.substring(2);
        } else if (keyword.startsWith("per")) {
          keyword = keyword.substring(3);
        } else if (keyword.startsWith("pem")) {
          if (regExpFlex.setPattern("[bfv]").hasMatch(keyword.substring(3, 4))) {
            keyword = keyword.substring(3);
          } else if (kamus.contains("p" + keyword.substring(3))) {
            keyword = "p" + keyword.substring(3);
          }
        } else if (keyword.startsWith("peny")) {
          if (kamus.contains("s" + keyword.substring(4))) {
            keyword = "s" + keyword.substring(4);
          }
        } else if (keyword.startsWith("pen")) {
          if (kamus.contains("t" + keyword.substring(3))) {
            keyword = "t" + keyword.substring(3);
          } else if (regExpFlex.setPattern("[jdcz]").hasMatch(keyword.substring(3, 4))) {
            keyword = keyword.substring(3);
          }
        }

      }
    }
    return keyword;
  }
}