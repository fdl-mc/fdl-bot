import 'package:nyxx/nyxx.dart';

const token = '<TOKEN>';

final guildId = Snowflake(705281809726046212);

final suggestsChannelId = Snowflake(719558307798581278);
final tradeChannelId = Snowflake(730431266394210354);

final statsChannelId = Snowflake(913679099040501760);
final mainStatsMessageId = Snowflake(914323747681484811);
final creativeStatsMessageId = Snowflake(914336276981891072);

final cacheOptions = CacheOptions()
  ..userCachePolicyLocation = CachePolicyLocation.none()
  ..memberCachePolicyLocation = CachePolicyLocation.none();
