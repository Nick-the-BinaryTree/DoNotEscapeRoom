namespace Areas;

require_once(__DIR__."/area.hack");
require_once(__DIR__."/../people/player.hack");
require_once(__DIR__."/../people/waiter.hack");

class Table implements \Areas\Area {
    private static function describeMenu(): void {
        echo "--The Menu--\n" .
            "Cookie - £1\n" .
            "Tea - £1'\n";
    }

    private static function speakToWaiter(): void {
        \People\Waiter::comeOver();
        \People\Waiter::speak();
        echo "You look over his white button down shirt. How traditional.\n" .
            "  (a) Buy a cookie.\n" .
            "  (b) Buy tea.\n" .
            "  (c) Dismiss him.\n";

        if (\People\Player::hasItem(\People\Player\ITEMS::DESIRE_TO_MARRY_ICELANDER)) {
            echo "  (d) Inquire about fax machine.\n";
        } elseif (\People\Player::hasItem(\People\Player\ITEMS::POEM)
            && !\People\Waiter::$heardPoem) {
            echo "  (d) Read poem.\n";
        }

        $choice = \readline('');

        if ($choice === "a") {
            if (\People\Player::getMoney() >= 1) {
                \People\Waiter::takeOrder();
                \People\Waiter::giveCookie();

                if (\People\Player::hasItem(\People\Player\ITEMS::TEA)) {
                    echo "You dip the cookie in the tea. This is what life was meant for.\n";
                }
            } else {
                echo "You don't have money to pay for the cookie. It's terribly awkward.\n";
            }
        } elseif ($choice === "b") {
            if (\People\Player::getMoney() >= 1) {
                \People\Waiter::takeOrder();
                \People\Waiter::giveTea();
            } else {
                echo "Free tea is to whimsical for any reality. Go acquire funds.\n";
            }
        } elseif ($choice === "d") {
            if (\People\Player::hasItem(\People\Player\ITEMS::DESIRE_TO_MARRY_ICELANDER)) {
                \People\Waiter::grantFaxMachineAccess();
            } elseif (\People\Player::hasItem(\People\Player\ITEMS::POEM)
                && !\People\Waiter::$heardPoem) {
                \People\Waiter::listenToPoem();
            } else {
                \People\Waiter::leave();
            }
        } else {
            \People\Waiter::leave();
        }
    }

    private static function readPoem(): void {
        echo "A Poem by " . \People\Player::getName() . "\n" .
            "'Nose nose nose nose nose,\n" .
            "You are attached to my face.'\n";
    }

    private static function writePoem(): void {
        \People\Player::addItem(\People\Player\ITEMS::POEM);

        echo "You scribble some lines.\n";
    }

    public static function queryPlayer(): bool {
        echo "\nYour arms rest comfortably over the table.\n" .
            "What do you do?\n" .
            "  (a) Look at the menu.\n" .
            "  (b) Call the waiter over.\n" .
            "  (c) " . (\People\Player::hasItem(\People\Player\ITEMS::POEM)
                ? "Read your poem"
            :   "Write a poem on the knapkin") . ".\n" .
            "  (d) Stand up.\n";

        $choice = \readline('');

        if ($choice === "a") {
            self::describeMenu();
        } elseif ($choice === "b") {
            self::speakToWaiter();
        } elseif ($choice === "c") {
            if (\People\Player::hasItem(\People\Player\ITEMS::POEM)) {
                self::readPoem();
            } else {
                self::writePoem();
            }
        } elseif ($choice === "d") {
            return true;
        }
        return false;
    }

    public function __toString(): string {
        return "A table where people typically sit.";
    }
}