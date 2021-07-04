import '../models/token.dart';
import '../models/dict.dart';
import '../rest/dict.dart';
import '../db/dict.dart';

class DictController{
  
  DictRest dictRest= new DictRest();
  DictDatabaseHelper dictDatabaseHelper = new DictDatabaseHelper();
  
  void downloadDictionary(String token)async{
    Dictionary dictionary=await dictRest.getDictionary(token);
    for(DictEntry entry in dictionary.list)
      await dictDatabaseHelper.insertDictEntry(entry);
    
  }

  Future<List<String>>getWordList()async
  {
    List<String>words=await dictDatabaseHelper.getWordList();
    return words;
  }

  Future<DictEntry>getDictEntry(String word)async{
    DictEntry entry= await dictDatabaseHelper.getEntry(word);
    await dictDatabaseHelper.insertFlashCardEntry(word);
    return entry;
  }

  Future<List<DictEntry>>getFlashCards()async{
    List<DictEntry>entries= await dictDatabaseHelper.getFlashCards();
    return entries;
  }

}