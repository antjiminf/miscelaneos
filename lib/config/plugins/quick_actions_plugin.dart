import 'package:miscelaneos/config/config.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugin {
  static registerActions() {
    final QuickActions quickActions = const QuickActions();

    quickActions.initialize((shortcutType) {
      switch (shortcutType) {
        case 'biometrics':
          router.push('/biometrics');
          break;
        case 'compass':
          router.push('/compass');
          break;
        case 'pokemons':
          router.push('/pokemons');
          break;
        case 'charmander':
          router.push('/pokemons/4');
          break;
        default:
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: 'biometrics',
        localizedTitle: 'Biometrics',
        icon: 'finger',
      ),
      ShortcutItem(type: 'compass', localizedTitle: 'Compass', icon: 'compass'),
      ShortcutItem(
        type: 'pokemons',
        localizedTitle: 'Pokemons',
        icon: 'pokemons',
      ),
      ShortcutItem(
        type: 'charmander',
        localizedTitle: 'Charmander',
        icon: 'charmander',
      ),
    ]);
  }
}
