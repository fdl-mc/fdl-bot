import 'package:nyxx/nyxx.dart';

// Guild
final guildId = Snowflake(705281809726046212);

// Voice channels
final onlineChannelId = Snowflake(733568472163811348);
final latencyChannelId = Snowflake(825926055620771890);
final stateChannelId = Snowflake(825931028106838016);

// Text channels
final suggestsChannelId = Snowflake(719558307798581278);
final tradeChannelId = Snowflake(730431266394210354);

final cacheOptions = CacheOptions()
  ..userCachePolicyLocation = CachePolicyLocation.none()
  ..memberCachePolicyLocation = CachePolicyLocation.none();
