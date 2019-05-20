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

function playSadEnding(bool $inDebt=false): void {
    if ($inDebt) {
        \readline("Having accrued unpayable debts, you are spirited from the establishment.");
        \readline("Unfortunately, it seems money is the least of your problems.");
    }
    \readline("The sad ending.");
}

function playLessSadEnding(): void {
    \readline("The less sad ending.");
}

function startGame(): void {
    $shouldMove = null;
    $currentArea = \Areas\AREAS::TABLE;

    // playIntro();

    while (!\People\Waiter::shouldKickOut()) {
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