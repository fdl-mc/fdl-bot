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
  String? additionalInfo,
  required User author,
}) {
  var embed = EmbedBuilder();

  embed.author = EmbedAuthorBuilder()
    ..iconUrl = author.avatarURL()
    ..name = 'Трейд запрос от ${author.tag}';

  embed
    ..addField(name: 'Отдам', content: willGive)
    ..addField(name: 'Получу', content: willGet);

  if (additionalInfo != null) {
    embed.addField(name: 'Доп. информация', content: additionalInfo);
  }

  embed.color = DiscordColor.cyan;

  return embed;
}
