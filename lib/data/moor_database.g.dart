// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Token extends DataClass implements Insertable<Token> {
  final String token;
  Token({@required this.token});
  factory Token.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Token(
      token:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}token']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || token != null) {
      map['token'] = Variable<String>(token);
    }
    return map;
  }

  TokensCompanion toCompanion(bool nullToAbsent) {
    return TokensCompanion(
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
    );
  }

  factory Token.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Token(
      token: serializer.fromJson<String>(json['token']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'token': serializer.toJson<String>(token),
    };
  }

  Token copyWith({String token}) => Token(
        token: token ?? this.token,
      );
  @override
  String toString() {
    return (StringBuffer('Token(')..write('token: $token')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(token.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || (other is Token && other.token == this.token);
}

class TokensCompanion extends UpdateCompanion<Token> {
  final Value<String> token;
  const TokensCompanion({
    this.token = const Value.absent(),
  });
  TokensCompanion.insert({
    @required String token,
  }) : token = Value(token);
  static Insertable<Token> custom({
    Expression<String> token,
  }) {
    return RawValuesInsertable({
      if (token != null) 'token': token,
    });
  }

  TokensCompanion copyWith({Value<String> token}) {
    return TokensCompanion(
      token: token ?? this.token,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TokensCompanion(')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }
}

class $TokensTable extends Tokens with TableInfo<$TokensTable, Token> {
  final GeneratedDatabase _db;
  final String _alias;
  $TokensTable(this._db, [this._alias]);
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  GeneratedTextColumn _token;
  @override
  GeneratedTextColumn get token => _token ??= _constructToken();
  GeneratedTextColumn _constructToken() {
    return GeneratedTextColumn(
      'token',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [token];
  @override
  $TokensTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tokens';
  @override
  final String actualTableName = 'tokens';
  @override
  VerificationContext validateIntegrity(Insertable<Token> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token'], _tokenMeta));
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Token map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Token.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TokensTable createAlias(String alias) {
    return $TokensTable(_db, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TokensTable _tokens;
  $TokensTable get tokens => _tokens ??= $TokensTable(this);
  TokensDao _tokensDao;
  TokensDao get tokensDao => _tokensDao ??= TokensDao(this as MoorDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tokens];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TokensDaoMixin on DatabaseAccessor<MoorDatabase> {
  $TokensTable get tokens => attachedDatabase.tokens;
}
