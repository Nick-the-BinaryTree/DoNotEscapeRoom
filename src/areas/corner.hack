namespace Areas;

require_once(__DIR__."/area.hack");
require_once(__DIR__."/../people/player.hack");

class Corner implements \Areas\Area {
    public static function queryPlayer(): bool {
        echo "The two dark rose walls meet majestically above a bare wood floor.\n" .
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
        } elseif ($choice === "c") {
            return true;
        }
        return false;
    }

    public function __toString(): string {
        return "A corner where one may stand.";
    }
}