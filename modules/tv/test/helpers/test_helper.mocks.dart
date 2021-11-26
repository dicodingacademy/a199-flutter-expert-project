// Mocks generated by Mockito 5.0.16 from annotations
// in tv/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i18;
import 'dart:typed_data' as _i19;

import 'package:core/core.dart' as _i10;
import 'package:core/data/datasources/db/database_helper.dart' as _i16;
import 'package:core/data/datasources/watchlist_local_data_source.dart' as _i14;
import 'package:core/data/models/watchlist_table.dart' as _i15;
import 'package:dartz/dartz.dart' as _i4;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i17;
import 'package:tv/data/datasources/tv_remote_data_source.dart' as _i6;
import 'package:tv/data/models/season_detail_model.dart' as _i3;
import 'package:tv/data/models/tv_detail_model.dart' as _i2;
import 'package:tv/data/models/tv_model.dart' as _i8;
import 'package:tv/domain/entities/season_detail.dart' as _i13;
import 'package:tv/domain/entities/tv.dart' as _i11;
import 'package:tv/domain/entities/tv_detail.dart' as _i12;
import 'package:tv/domain/repositories/tv_repository.dart' as _i9;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvDetailModel_0 extends _i1.Fake implements _i2.TvDetailModel {}

class _FakeSeasonDetailModel_1 extends _i1.Fake
    implements _i3.SeasonDetailModel {}

class _FakeEither_2<L, R> extends _i1.Fake implements _i4.Either<L, R> {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [TvRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDataSource extends _i1.Mock
    implements _i6.TvRemoteDataSource {
  MockTvRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i8.TvModel>> getNowPlayingTvs() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvs, []),
              returnValue: Future<List<_i8.TvModel>>.value(<_i8.TvModel>[]))
          as _i7.Future<List<_i8.TvModel>>);
  @override
  _i7.Future<List<_i8.TvModel>> getPopularTvs() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvs, []),
              returnValue: Future<List<_i8.TvModel>>.value(<_i8.TvModel>[]))
          as _i7.Future<List<_i8.TvModel>>);
  @override
  _i7.Future<List<_i8.TvModel>> getTopRatedTvs() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvs, []),
              returnValue: Future<List<_i8.TvModel>>.value(<_i8.TvModel>[]))
          as _i7.Future<List<_i8.TvModel>>);
  @override
  _i7.Future<_i2.TvDetailModel> getTvDetail(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvDetail, [id]),
          returnValue: Future<_i2.TvDetailModel>.value(_FakeTvDetailModel_0()))
      as _i7.Future<_i2.TvDetailModel>);
  @override
  _i7.Future<List<_i8.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue: Future<List<_i8.TvModel>>.value(<_i8.TvModel>[]))
          as _i7.Future<List<_i8.TvModel>>);
  @override
  _i7.Future<List<_i8.TvModel>> searchTvs(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvs, [query]),
              returnValue: Future<List<_i8.TvModel>>.value(<_i8.TvModel>[]))
          as _i7.Future<List<_i8.TvModel>>);
  @override
  _i7.Future<_i3.SeasonDetailModel> getTvSeasonDetail(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTvSeasonDetail, [id, seasonNumber]),
              returnValue: Future<_i3.SeasonDetailModel>.value(
                  _FakeSeasonDetailModel_1()))
          as _i7.Future<_i3.SeasonDetailModel>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i9.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i4.Either<_i10.Failure, List<_i11.Tv>>> getNowPlayingTvs() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvs, []),
          returnValue: Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_2<_i10.Failure, List<_i11.Tv>>())) as _i7
          .Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  _i7.Future<_i4.Either<_i10.Failure, List<_i11.Tv>>> getPopularTvs() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvs, []),
          returnValue: Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_2<_i10.Failure, List<_i11.Tv>>())) as _i7
          .Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  _i7.Future<_i4.Either<_i10.Failure, List<_i11.Tv>>> getTopRatedTvs() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvs, []),
          returnValue: Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_2<_i10.Failure, List<_i11.Tv>>())) as _i7
          .Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  _i7.Future<_i4.Either<_i10.Failure, _i12.TvDetail>> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
          returnValue: Future<_i4.Either<_i10.Failure, _i12.TvDetail>>.value(
              _FakeEither_2<_i10.Failure, _i12.TvDetail>())) as _i7
          .Future<_i4.Either<_i10.Failure, _i12.TvDetail>>);
  @override
  _i7.Future<_i4.Either<_i10.Failure, List<_i11.Tv>>> getTvRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
          returnValue: Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_2<_i10.Failure, List<_i11.Tv>>())) as _i7
          .Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  _i7.Future<_i4.Either<_i10.Failure, List<_i11.Tv>>> searchTvs(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvs, [query]),
          returnValue: Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_2<_i10.Failure, List<_i11.Tv>>())) as _i7
          .Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  _i7.Future<_i4.Either<_i10.Failure, _i13.SeasonDetail>> getTvSeasonDetail(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTvSeasonDetail, [id, seasonNumber]),
              returnValue:
                  Future<_i4.Either<_i10.Failure, _i13.SeasonDetail>>.value(
                      _FakeEither_2<_i10.Failure, _i13.SeasonDetail>()))
          as _i7.Future<_i4.Either<_i10.Failure, _i13.SeasonDetail>>);
  @override
  _i7.Future<_i4.Either<_i10.Failure, String>> saveWatchlist(
          _i12.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tv]),
              returnValue: Future<_i4.Either<_i10.Failure, String>>.value(
                  _FakeEither_2<_i10.Failure, String>()))
          as _i7.Future<_i4.Either<_i10.Failure, String>>);
  @override
  _i7.Future<_i4.Either<_i10.Failure, String>> removeWatchlist(
          _i12.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
              returnValue: Future<_i4.Either<_i10.Failure, String>>.value(
                  _FakeEither_2<_i10.Failure, String>()))
          as _i7.Future<_i4.Either<_i10.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i4.Either<_i10.Failure, List<_i11.Tv>>> getWatchlistTvs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvs, []),
          returnValue: Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_2<_i10.Failure, List<_i11.Tv>>())) as _i7
          .Future<_i4.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [WatchlistLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistLocalDataSource extends _i1.Mock
    implements _i14.WatchlistLocalDataSource {
  MockWatchlistLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i15.WatchlistTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i15.WatchlistTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i15.WatchlistTable?> getWatchlistById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getWatchlistById, [id]),
              returnValue: Future<_i15.WatchlistTable?>.value())
          as _i7.Future<_i15.WatchlistTable?>);
  @override
  _i7.Future<List<_i15.WatchlistTable>> getWatchlistTvList() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvList, []),
              returnValue: Future<List<_i15.WatchlistTable>>.value(
                  <_i15.WatchlistTable>[]))
          as _i7.Future<List<_i15.WatchlistTable>>);
  @override
  _i7.Future<List<_i15.WatchlistTable>> getWatchlistTvs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvs, []),
              returnValue: Future<List<_i15.WatchlistTable>>.value(
                  <_i15.WatchlistTable>[]))
          as _i7.Future<List<_i15.WatchlistTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i16.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i17.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i17.Database?>.value())
          as _i7.Future<_i17.Database?>);
  @override
  _i7.Future<int> insertWatchlist(_i15.WatchlistTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlist(_i15.WatchlistTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getWatchlistById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getWatchlistById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTvList() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvList, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTvs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvs, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i19.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i19.Uint8List>.value(_i19.Uint8List(0)))
          as _i7.Future<_i19.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
