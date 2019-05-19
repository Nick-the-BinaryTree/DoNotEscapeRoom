namespace Game;

require_once(__DIR__.'/people/player.hack');

function startGame(): void {

    $p = new \People\Player();

    $p->describe();
    $p->addItem('ham');
    $p->addMoney(20);
    $p->setName('tim');
    $p->describe();
    $p->hasItem('ham');
    $p->hasItem('not ham');
    $p->removeItem('ham');
    $p->removeMoney(10);
    $p->describe();


    // \readline("You're sitting in such a delightful room.");
    // \readline("The furniture is tasteful.");
    // \readline("The people are elegant.");
    // \readline("The sounds are amicable.");
    // \readline("A staff member eyes you anxiously.");
    // \readline("You did after all-");
    // \readline("...finish your food six hours and fourteen minutes ago.");

    // echo "\nYour arms rest comfortably over the table.\n" .
    //   "What do you do?\n" .
    //   "  (a) Look at the menu.\n" .
    //   "  (b) Call the waiter over.\n" .
    //   "  (c) Write a poem on the knapkin.\n";

    // $choice = \readline('');

    // echo $choice;
}