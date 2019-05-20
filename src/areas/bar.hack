namespace Areas;

require_once(__DIR__."/area.hack");
require_once(__DIR__."/../people/magistrate.hack");
require_once(__DIR__."/../people/player.hack");
require_once(__DIR__."/../people/woman.hack");

class Bar implements \Areas\Area {
    public static function queryPlayer(): bool {
        echo "\nThe mahogany bar glows under the warm light of a lamp suspended overhead.\n" .
            "Droplets of various beverages sparkle on its surface.\n" .
            "There is a woman to your left and a magistrate to the right.\n" .
            "What now?\n" .
            "  (a) Speak to the woman.\n" . 
            "  (b) Speak to the magistrate.\n" .
            "  (c) Depart from the bar.\n";

        $choice = \readline('');

        if ($choice === "a") {
            \People\Woman::speak();
        } elseif ($choice === "b") {
            \People\Magistrate::speak();
        } elseif ($choice === "c") {
            return true;
        }
        return false;
    }

    public function __toString(): string {
        return "A trendy bar.";
    }
}