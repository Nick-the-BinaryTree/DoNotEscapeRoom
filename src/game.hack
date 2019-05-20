namespace Game;

use namespace HH\Lib\Vec;

// require_once(__DIR__.'/areas/bar.hack');
// require_once(__DIR__.'/areas/corner.hack');
require_once(__DIR__.'/areas/table.hack');
require_once(__DIR__.'/people/player.hack');
require_once(__DIR__.'/people/waiter.hack');

function playIntro(): void {
    \readline("You're sitting in such a delightful room.");
    \readline("The furniture is tasteful.");
    \readline("The people are elegant.");
    \readline("The sounds are amicable.");
    \readline("A staff member eyes you anxiously.");
    \readline("You did after all-");
    \readline("...finish your food six hours and fourteen minutes ago.");
}

function playHappyEnding(): void {
    \readline("Soldiers burst into the room.");
    \readline("You can see the tiny Icelandic flags on the breast pockets of their uniforms.");
    \readline("Your wife starts saying something in Icelandic.");
    \readline("The soldiers take both of you away.");
    \readline("Over your shoulder, you see the waiter and the magistrate being herded
        into a larger group of prisoners in town square.");
    \readline("...");
    \readline("Many years later, in Reykjavík,");
    \readline("You will reminisce about the delightful room.");
    \readline("And while you will be sad that it's gone,");
    \readline("You will be grateful for the time you had in it.");
    \readline("THE END OF DO NOT ESCAPE ROOM");
}

function playSadEnding(bool $inDebt=false): void {
    if ($inDebt) {
        \readline("Having accrued unpayable debts, you are spirited from the establishment.");
        \readline("Unfortunately, it seems money is the least of your problems.");
    }
    \readline("You kick around some gravel outside.");
    \readline("The chilly air forms little clouds of fog where you breathe.");
    \readline("A tank with an Icelandic flag rolls up the street.");
    \readline("As the soldiers take you away,");
    \readline("You wonder if things could have been different.");
}

function startGame(): void {
    $shouldMove = null;
    $currentArea = \Areas\AREAS::TABLE;
    $winCountdown = 3;

    playIntro();

    while (!\People\Waiter::shouldKickOut()) {
        if (\People\Player::hasItem(\People\Player\ITEMS::MARRIAGE_WITH_ICELANDER)) {
            $winCountdown--;

            if ($winCountdown === 0) {
                playHappyEnding();
                return;
            }
        }

        $shouldMove = false;

        if ($currentArea  === \Areas\AREAS::TABLE) {
            $shouldMove = \Areas\Table::queryPlayer();
        }
        if (\People\Player::getMoney() < 0) {
            playSadEnding(true);
            return;
        }
        if ($shouldMove) {
            $destinations = Vec\filter(
                Vec\keys(\Areas\AREAS::getNames()),
                $destination ==> $destination !== $currentArea
            );
            echo "Where would you like to go?\n" .
                 "  (a) " . $destinations[0] . "\n" .
                 "  (b) " . $destinations[1] . "\n" .
                 "  (c) No where.\n" . 
                 "  (d) Outside. This is the incorrect choice.\n";
            
            $choice = \readline('');

            if ($choice === "a") {
                $currentArea = $destinations[0];
            } elseif ($choice === "b") {
                $currentArea = $destinations[1];
            } elseif ($choice === "d") {
                break;
            }
        }
    }
    playSadEnding();
}