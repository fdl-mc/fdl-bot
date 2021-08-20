import 'package:nyxx/nyxx.dart';

EmbedBuilder buildSuggestionEmbed({
  required String title,
  String? description,
  required User author,
}) {
  var embed = EmbedBuilder();

  embed.author = EmbedAuthorBuilder()
    ..iconUrl = author.avatarURL()
    ..name = 'Идея от ${author.tag}';

  embed
    ..title = title
    ..description = description
    ..color = DiscordColor.yellow;

  return embed;
}

EmbedBuilder buildTradeEmbed({
  required String willGive,
  required String willGet,
  required User author,
}) {
  var embed = EmbedBuilder();

  embed.author = EmbedAuthorBuilder()
    ..iconUrl = author.avatarURL()
    ..name = 'Трейд запрос от ${author.tag}';

  embed
    ..addField(name: 'Отдам', content: willGive)
    ..addField(name: 'Получу', content: willGet);

  embed.color = DiscordColor.springGreen;

  return embed;
}
