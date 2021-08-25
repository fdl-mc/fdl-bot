import 'package:fdl_api/fdl_api.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/interactions.dart';

import 'commands/suggest_command.dart';
import 'commands/trade_command.dart';
import 'utils/builders.dart';
import 'utils/constants.dart';
import 'utils/instances.dart';
import 'workers/server_state_updater.dart';

void main(List<String> arguments) {
  bot = Nyxx(
    '<TOKEN>',
    GatewayIntents.all,
    options: ClientOptions(
      initialPresence: initialPresence,
    ),
    cacheOptions: cacheOptions,
  );

  updateState(FdlApi('igorechek.ddns.net:3000'), bot);

  interactions = Interactions(bot)
    ..registerSlashCommand(suggestCommand)
    ..registerSlashCommand(tradeCommand)
    ..syncOnReady();
}
