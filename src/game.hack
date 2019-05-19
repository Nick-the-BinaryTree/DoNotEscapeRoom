namespace Game;

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

function playSadEnding(): void {
    \readline("The sad ending.");
}

function playLessSadEnding(): void {
    \readline("The less sad ending.");
}

function startGame(): void {

    // \People\Player::describe();
    // \People\Player::addItem('ham');
    // \People\Player::addMoney(20);
    // \People\Player::setName('tim');
    // \People\Player::describe();
    // \People\Player::hasItem('ham');
    // \People\Player::hasItem('not ham');
    // \People\Player::removeItem('ham');
    // \People\Player::removeMoney(10);
    // \People\Player::describe();

    playIntro();

    while (!\People\Waiter::shouldKickOut()) {

    }

    playSadEnding();
    // echo "\nYour arms rest comfortably over the table.\n" .
    //   "What do you do?\n" .
    //   "  (a) Look at the menu.\n" .
    //   "  (b) Call the waiter over.\n" .
    //   "  (c) Write a poem on the knapkin.\n";

    // $choice = \readline('');

    // echo $choice;
}