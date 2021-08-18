import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/interactions.dart';

import 'utils/builders.dart';
import 'utils/instances.dart';

void main(List<String> arguments) {
  bot = Nyxx(
    '<TOKEN>',
    GatewayIntents.all,
    options: ClientOptions(
      initialPresence: initialPresence,
    ),
  );

  interactions = Interactions(bot);
}