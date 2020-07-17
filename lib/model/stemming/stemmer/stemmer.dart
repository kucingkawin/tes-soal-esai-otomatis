import 'package:tessoal/model/stemming/stemmer/prefix.dart';
import 'package:tessoal/model/stemming/stemmer/reduplikasi.dart';
import 'package:tessoal/model/stemming/stemmer/suffix.dart';

class Stemmer {

  List kamus;
  String rootWord;

  Stemmer(List kamus) {
    this.kamus = kamus;
  }

  String getRootWord(String keyword) {
    String output = this.getRootWord2(keyword, null);
    return output;
  }

  String getRootWord2(String keyword, String defaultWord) {
    if (this.hasRootWord(keyword)) {
      return this.rootWord;
    } else {
      return defaultWord;
    }
  }

  bool hasRootWord(String keyword){
    String rootWord = _fetch(keyword);
    return kamus.contains(_fetch(keyword));
  }

  String _fetch(String keyword){
    this.rootWord = keyword;
    this.rootWord = new Reduplikasi(kamus).remove(rootWord);
    this.rootWord = new Prefix(kamus).remove(rootWord);
    this.rootWord = new Suffix(kamus).remove(rootWord);
    return rootWord;
  }
}