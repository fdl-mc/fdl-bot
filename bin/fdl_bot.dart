import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/interactions.dart';

import 'commands/suggest_command.dart';
import 'commands/trade_command.dart';
import 'utils/builders.dart';
import 'utils/config.dart';
import 'utils/instances.dart';
import 'workers/creative_server_state_updater.dart';
import 'workers/main_server_state_updater.dart';

void main(List<String> arguments) {
  bot = Nyxx(
    token,
    GatewayIntents.all,
    options: ClientOptions(
      initialPresence: initialPresence,
    ),
    cacheOptions: cacheOptions,
  );

  updateMainStats(bot);
  updateCreativeStats(bot);

  interactions = Interactions(bot)
    ..registerSlashCommand(suggestCommand)
    ..registerSlashCommand(tradeCommand)
    ..syncOnReady();
}
