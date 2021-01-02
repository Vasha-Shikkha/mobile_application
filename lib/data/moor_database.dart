import 'package:Vasha_Shikkha/data/tables/token.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

@UseDao(tables: [Tokens])
class TokensDao extends DatabaseAccessor<MoorDatabase> with _$TokensDaoMixin {
  TokensDao(MoorDatabase db) : super(db);
  Future<List<Token>> get allTokens => select(tokens).get();
  Stream<List<Token>> get watchAllTokens => select(tokens).watch();

  ///Adds a token...
  void addToken({String token}) {
    final _entry = TokensCompanion(
      token: Value(token),
    );
    into(tokens).insert(_entry);
  }
}

// this annotation tells moor to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@UseMoor(tables: [Tokens], daos: [TokensDao])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));
  int get schemaVersion => 1;
}
