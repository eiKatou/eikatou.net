---
title: SQLiteのポイント
author: eiKatou
type: post
date: 2010-10-24T09:30:52+00:00
url: /48.html
tags:
  - Android
  - App
  - Dev

---
## DBHelperはSingletonで

SQLiteOpenHelperを継承したDatabaseHelperというクラスを作成しました。このDatabaseHelperはSingletonが良さそうです。

毎回、new DatabaseHelper(context)を返していたところ、複数スレッドからのDBアクセスでエラー(DBファイルのlock)が出てしまいました。複数スレッドで別のインスタンスを扱っていたのが原因のようでした。ご注意を。
  
[java]
  
public class DatabaseHelper extends SQLiteOpenHelper {
      
private static DatabaseHelper instance = null;
      
private static final String DATABASE_NAME = "AnniversaryDB";
      
private static final int DATABASE_VERSION = 1;
      
private DatabaseHelper(Context context) {
          
super(context, DATABASE\_NAME, null, DATABASE\_VERSION);
      
}
      
public static DatabaseHelper getInstance(Context context) {
          
if (instance == null) {
              
instance = new DatabaseHelper(context);
          
}
          
return instance;
      
}
      
@Override
      
public void onCreate(SQLiteDatabase db) {
          
// create table
      
}
      
@Override
      
public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
          
// drop table
          
// create table
      
}
  
}

[/java]

このSingletonは手抜き工事ですが、サンプルですので。呼び出し側のソースは、次のトランザクションの項目で出てきます。

## トランザクション

トランザクションをかけるのを忘れずに。読み込みの時は、getReadableDatabase()で読み込み専用のインスタンスを取得できます。「closeは明示的にしなくても良い」と書いてあるブログ(<a href="http://d.hatena.ne.jp/ukiki999/20100524/p1" target="_blank">ここ</a>)を発見したのですが、closeしないとエラーで怒られました。どっちが良いのでしょうか・・? <a href="http://developer.android.com/reference/android/database/sqlite/SQLiteDatabase.html#beginTransaction%28%29" target="_blank">サンプル</a>はcloseしていないので、closeしない方がよいのかもしれません。
  
[java]
  
@Override
  
public Profile getProfile(Context context, long id) {
      
DatabaseHelper dbHelper = DatabaseHelper.getInstance(context);
      
SQLiteDatabase db = dbHelper.getReadableDatabase();
      
Profile profile = null;
      
try {
          
db.beginTransaction();
          
ProfileDao profileDao = DaoFactory.getProfileDao(db);
          
profile = profileDao.findById(id);
          
db.setTransactionSuccessful();
      
} finally {
      
db.endTransaction();
      
db.close();
      
}
      
return profile;
  
}

[/java]

## Cusorを閉じる

queryを発行して返されたCusorをループで回しますが、回し終わったらcloseしましょう。これもエラーで怒られました。
  
[java]
  
@Override
  
public List<Profile> findAll() {
      
List<Profile> profileList = new ArrayList<Profile>();
      
Cursor cursor = db.query(TABLE_NAME, COLUMNS, null, null,
          
null, null, COLUMN_ID);
      
while (cursor.moveToNext()) {
          
Profile profile = new Profile();
          
profile.setId(cursor.getInt(COLUMN\_ID\_INDEX));
          
profileList.add(profile);
      
}
      
cursor.close();
      
return profileList;
  
}

[/java] 

## 高速化

SQLiteStatementを事前にコンパイルして、発行した方が早いです。
  
[java]
  
// insert statement
  
private static SQLiteStatement insertStatement;
  
private static final String insertSql = "insert into " + TABLE_NAME + " values(null, ?, ?);";
  
public void setDb(SQLiteDatabase db) {
      
this.db = db;
      
insertStatement = db.compileStatement(insertSql);
  
}
  
@Override
  
public long insert(Anniversary anniversary) {
      
insertStatement.bindLong(COLUMN\_PROFILEID\_INDEX, anniversary.getProfileId());
      
insertStatement.bindLong(COLUMN\_TYPE\_INDEX, anniversary.getType());
      
return insertStatement.executeInsert();
  
}

[/java]
