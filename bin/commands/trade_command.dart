import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/interactions.dart';

import '../utils/config.dart';
import '../utils/instances.dart';
import '../utils/typedefs.dart';
import '../utils/utils.dart';

final tradeCommand = SlashCommandBuilder(
  'trade',
  'Выставить трейд.',
  _tradeCommandOptions,
  guild: guildId,
)..registerHandler(_tradeCommandExecution);

final _tradeCommandOptions = [
  CommandOptionBuilder(
    CommandOptionType.string,
    'отдам',
    'То, что вы отдаёте.',
    required: true,
  ),
  CommandOptionBuilder(
    CommandOptionType.string,
    'получу',
    'То, что вы получите.',
    required: true,
  ),
  CommandOptionBuilder(
    CommandOptionType.string,
    'дополнительно',
    'Дополнительная информация.',
  ),
];

final CommandExecution _tradeCommandExecution = (event) async {
  final channel = await bot.fetchChannel<TextChannel>(tradeChannelId);
  final willGive = event.interaction.getArg('отдам').value as String;
  final willGet = event.interaction.getArg('получу').value as String;
  final additionalInfo = event.interaction.getArg('дополнительно') != null
      ? event.interaction.getArg('дополнительно').value
      : null;

  final msg = await channel.sendMessage(
    MessageBuilder.embed(
      buildTradeEmbed(
        willGive: willGive,
        willGet: willGet,
        additionalInfo: additionalInfo,
        author: event.interaction.userAuthor!,
      ),
    ),
  );

  await event.respond(
    MessageBuilder.content('Запрос на трейд успешно отправлен!'),
    hidden: true,
  );

  await msg.createThread(ThreadBuilder('Комментарии'));
};
