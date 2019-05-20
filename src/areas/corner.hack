namespace Areas;

require_once(__DIR__."/area.hack");
require_once(__DIR__."/../people/player.hack");

class Corner implements \Areas\Area {
    public static function queryPlayer(): bool {
        echo "\nThe two dark rose walls meet majestically above a bare wood floor.\n" .
            "You stand in the corner of the rectangular room.\n" .
            "What now?\n" .
            "  (a) Look out the window.\n" . 
            "  (b) Introspect.\n" .
            "  (c) Leave the corner.\n";

        $choice = \readline('');

        if ($choice === "a") {
            echo "Something stirs in the distance.\n" .
                "Something menacing.\n" .
                "How nice to be inside.\n";
        } elseif ($choice === "b") {
            \People\Player::describe();

            if (\People\Player::hasItem(\People\Player\ITEMS::DESIRE_TO_KNOW_NAME)) {
                \readline("What a bother. Not having a name.");
                \readline("Oh, but you must have one.");
                \readline("From long ago...");
                \readline("What was it again?");
                \readline("You think hard.");
                \readline("Your position in the corner starts to blend with an old memory.");
                \readline("An old memory from yesterday.");
                \readline("You were checking out a book from the library.");
                \readline("Hitchhiker's Guide to the Galaxy.");
                \readline("You used your library card.");
                \readline("It had your name on it.");
                \readline("You twitch a bit and grasp around in your pocket for the card.");
                \readline("The outline of its rectangular shape bends between your fingers.");
                \readline("You lift the card to your eyes.");
                \readline("It reads: \"Hugo\".");
                
                \People\Player::removeItem(\People\Player\ITEMS::DESIRE_TO_KNOW_NAME);
                \People\Player::addItem(\People\Player\ITEMS::NAME);
                \People\Player::setName("Hugo");
            }
        } elseif ($choice === "c") {
            return true;
        }
        return false;
    }

    public function __toString(): string {
        return "A corner where one may stand.";
    }
}