import 'package:fdl_api/fdl_api.dart';
import 'package:nyxx/nyxx.dart';

import '../utils/constants.dart';

Future<void> updateState(FdlApi fdlApi, Nyxx bot) async {
  final onlineChannel =
      await bot.fetchChannel<VoiceGuildChannel>(onlineChannelId);
  final pingChannel =
      await bot.fetchChannel<VoiceGuildChannel>(latencyChannelId);
  final stateChannel =
      await bot.fetchChannel<VoiceGuildChannel>(stateChannelId);

  await Future.doWhile(() async {
    ServerStats? stats;
    try {
      stats = await fdlApi.getMainServerStats();
    } catch (e) {
      await onlineChannel.edit(
        ChannelBuilder()..name = 'Онлайн: N/A',
      );

      await pingChannel.edit(
        ChannelBuilder()..name = 'Пинг: N/A',
      );

      await stateChannel.edit(
        ChannelBuilder()..name = 'Состояние: Оффлайн',
      );
    }

    await onlineChannel.edit(
      ChannelBuilder()
        ..name = 'Онлайн: ${stats!.players.online}/${stats.players.max}',
    );

    await pingChannel.edit(
      ChannelBuilder()..name = 'Пинг: ~${stats.latency} мс',
    );

    await stateChannel.edit(
      ChannelBuilder()..name = 'Состояние: Онлайн',
    );

    await Future.delayed(Duration(seconds: 60));
    return true;
  });
}
