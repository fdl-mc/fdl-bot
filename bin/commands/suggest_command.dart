import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/interactions.dart';

import '../utils/constants.dart';
import '../utils/instances.dart';
import '../utils/typedefs.dart';
import '../utils/utils.dart';

final suggestCommand = SlashCommandBuilder(
  'suggest',
  'Предложить идею.',
  _suggestCommandOptions,
  guild: guildId,
)..registerHandler(_suggestCommandExecution);

final _suggestCommandOptions = [
  CommandOptionBuilder(
    CommandOptionType.string,
    'заголовок',
    'Заголовок идеи.',
    required: true,
  ),
  CommandOptionBuilder(
    CommandOptionType.string,
    'описание',
    'Описание идеи.',
  ),
];

final CommandExecution _suggestCommandExecution = (event) async {
  final channel = await bot.fetchChannel<TextChannel>(suggestsChannelId);
  final title = event.interaction.getArg('заголовок').value as String;
  final description = event.interaction.getArg('описание') is InteractionOption
      ? event.interaction.getArg('описание').value
      : null;
  print(description);

  final msg = await channel.sendMessage(
    MessageBuilder.embed(
      buildSuggestionEmbed(
        title: title,
        description: description,
        author: event.interaction.userAuthor!,
      ),
    ),
  );

  await event.respond(
    MessageBuilder.content('Идея успешно отправлена!'),
    hidden: true,
  );

  await msg.createReaction(UnicodeEmoji('👍'));
  await msg.createReaction(UnicodeEmoji('👎'));

  await msg.createThread(ThreadBuilder('Комментарии'));
};
