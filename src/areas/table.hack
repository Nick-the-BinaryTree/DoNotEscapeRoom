namespace Areas;

require_once(__DIR__."/area.hack");
require_once(__DIR__."/../items.hack");
require_once(__DIR__."/../people/player.hack");
require_once(__DIR__."/../people/waiter.hack");

class Table implements \Areas\Area {
    private static function describeMenu(): void {
        echo "--The Menu--\n" .
            "Cookie - £1\n" .
            "Tea - £1'\n";
    }

    private static function speakToWaiter(): void {
        echo "\nThe waiter, an utterly normal looking fellow, shuffles over.\n";
        \People\Waiter::speak();
        echo "\nYou look over his solid white collared shirt. How traditional.\n" .
            "  (a) Buy a cookie.\n" .
            "  (b) Buy tea.\n" .
            "  (c) Dismiss him.\n";

        if (\People\Player::hasItem(\Items\ITEMS::POEM)) {
            echo "  (d) Read poem.\n";
        }

        $choice = \readline('');

        if ($choice === "a") {
            if (\People\Player::getMoney() >= 1) {
                \People\Waiter::takeOrder();
                echo "The waiter provides you with a single cookie. It glistens slightly.\n";
                \People\Player::addItem(\Items\ITEMS::COOKIE);

                if (\People\Player::hasItem(\Items\ITEMS::TEA)) {
                    echo "You dip the cookie in the tea. This is what life was meant for.\n";
                }
                \People\Player::removeMoney(1);
            } else {
                echo "You don't have money to pay for the cookie. It's terribly awkward.\n";
            }
        } elseif ($choice === "b") {
            if (\People\Player::getMoney() >= 1) {
                \People\Waiter::takeOrder();
                \People\Player::addItem(\Items\ITEMS::TEA);
                echo "The waiter places a polished mug on the table and gently pours Earl Grey.\n";
                \People\Player::removeMoney(1);
            } else {
                echo "Free tea is to whimsical for any reality. Go acquire funds.\n";
            }
        } elseif ($choice === "d" && \People\Player::hasItem(\Items\ITEMS::POEM)) {
            echo "A sparkle of adoration flickers across the waiter's eyes.\n" .
             "He blinks and scurries off.";
        } else {
            echo "The waiter raises a furry black eyebrow and leaves without a word.\n";
        }
    }

    private static function readPoem(): void {
        echo "A Poem by " . \People\Player::getName() . "\n" .
            "'Nose nose nose nose nose,\n" .
            "You are attached to my face.'\n";
    }

    private static function writePoem(): void {
        \People\Player::addItem(\Items\ITEMS::POEM);

        echo "You scribble some lines.\n";
    }

    public static function queryPlayer(): bool {
        echo "\n\nYour arms rest comfortably over the table.\n" .
            "What do you do?\n" .
            "  (a) Look at the menu.\n" .
            "  (b) Call the waiter over.\n" .
            "  (c) " . (\People\Player::hasItem(\Items\ITEMS::POEM)
                ? "Read your poem"
            :   "Write a poem on the knapkin") . ".\n" .
            "  (d) Stand up.\n";

        $choice = \readline('');

        if ($choice === "a") {
            self::describeMenu();
        } elseif($choice === "b") {
            self::speakToWaiter();
        } elseif($choice === "c") {
            if (\People\Player::hasItem(\Items\ITEMS::POEM)) {
                self::readPoem();
            } else {
                self::writePoem();
            }
        } else {
            return true;
        }
        return false;
    }

    public function __toString(): string {
        return "A table where people typically sit.";
    }
}