import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/interactions.dart';

import '../utils/constants.dart';
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
];

final CommandExecution _tradeCommandExecution = (event) async {
  final channel = await bot.fetchChannel<TextChannel>(suggestsChannelId);
  final willGive = event.interaction.getArg('отдам').value as String;
  final willGet = event.interaction.getArg('получу').value as String;

  final msg = await channel.sendMessage(
    MessageBuilder.embed(
      buildTradeEmbed(
        willGive: willGive,
        willGet: willGet,
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
