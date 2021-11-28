import 'package:dart_minecraft/dart_minecraft.dart';
import 'package:nyxx/nyxx.dart';

import '../utils/config.dart';

Future<void> updateCreativeStats(Nyxx bot) async {
  final stateChannel = await bot.fetchChannel<TextGuildChannel>(statsChannelId);
  final message = await stateChannel.fetchMessage(creativeStatsMessageId);

  await Future.doWhile(() async {
    try {
      final server = await ping(
        'creative.fdl-mc.ru',
        timeout: Duration(seconds: 5),
      );

      final online =
          '${server!.response!.players.online}/${server.response!.players.max}';
      final players =
          server.response!.players.sample.map((e) => '`${e.name}`').join(', ');
      final embed = EmbedBuilder()
        ..color = DiscordColor.green
        ..addField(name: 'Состояние', content: 'Онлайн', inline: true)
        ..addField(name: 'Айпи', content: 'creative.fdl-mc.ru', inline: true)
        ..addField(name: 'Игроков онлайн', content: online, inline: true);

      if (server.response!.players.online > 0) {
        embed.addField(
          name: 'Сейчас на сервере',
          content: players,
          inline: false,
        );
      }

      await message.edit(MessageBuilder()
        ..appendBold('Статистика Creative сервера:')
        ..embeds = [embed]);
    } catch (e) {
      print(e);
      await message.edit(MessageBuilder()
        ..appendBold('Статистика Creative сервера:')
        ..embeds = [
          EmbedBuilder()
            ..color = DiscordColor.red
            ..addField(name: 'Состояние', content: 'Оффлайн', inline: true)
            ..addField(
                name: 'Айпи', content: 'creative.fdl-mc.ru', inline: true)
            ..addField(name: 'Игроков онлайн', content: 'N/A', inline: true),
        ]);
    }

    await Future.delayed(Duration(seconds: 20));
    return true;
  });
}
