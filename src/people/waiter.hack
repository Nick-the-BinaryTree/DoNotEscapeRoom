namespace People;

require_once(__DIR__."/npc.hack");
require_once(__DIR__."/player.hack");

class Waiter implements \People\NPC {
    private static int $annoyance = 5;
    public static bool $heardPoem = false;

    private static function brood(): void {
        self::$annoyance++;
    }

    public static function comeOver(): void {
        echo "The waiter, an utterly normal looking fellow, shuffles over.\n";
    }

    public static function giveCookie(): void {
        echo "The waiter provides you with a single cookie. It glistens slightly.\n";
        \People\Player::addItem(\People\Player\ITEMS::COOKIE);
        \People\Player::removeMoney(1);
    }

    public static function giveTea(): void {
        echo "The waiter places a polished mug on the table and gently pours Earl Grey.\n";
        \People\Player::addItem(\People\Player\ITEMS::TEA);
        \People\Player::removeMoney(1);
    }

    public static function grantFaxMachineAccess(): void {
        echo "Err, yes we have a fax machine. I can get it going for you.\n";
        \People\Player::addItem(\People\Player\ITEMS::FAX_MACHINE_ACCESS);
    }

    public static function leave(): void {
        echo "The waiter raises a furry black eyebrow and leaves without a word.\n";
    }

    public static function listenToPoem(): void {
        self::$heardPoem = true;

        echo "A sparkle of adoration flickers across the waiter's eyes.\n" .
            "He blinks and scurries off.\n" .
            "A pound lays on the table.\n";
        \People\Player::addMoney(1);
    }

    public static function shouldKickOut(): bool {
        self::brood();
        
        if (self::$annoyance >= 20) {
            self::speak();

            return true;
        }
        return false;
    }

    public static function takeOrder(): void {
        self::$annoyance -= 15;
    }

    public static function speak(): void {
        if (self::$annoyance < 1) {
            echo "\"Delightful patron, I rejoice at your presence before me.\"\n";
        } elseif (self::$annoyance < 5) {
            echo "\"Anything I can help you with?\"\n";
        } elseif (self::$annoyance < 10) {
            echo "\"It's been a while, can I get you anything?\"\n";
        } elseif (self::$annoyance < 15) {
            echo "\"It's a bit busy, and if you're done eating, we could use the table.\"\n";
        } elseif (self::$annoyance < 18) {
            echo "\"An ill-mannered, saucy fellow thou art.\"\n";
        } elseif (self::$annoyance < 20) {
            echo "\"Horswoggling fungus.\"\n";
        } else {
            echo "The waiter suddenly bears down on you.\n" .
             "\"I'm sorry, but it's been hours since you've ordered anything,\n" .
             "and we need this table for other customers.\"\n";
        }
        
    }

    public function __toString(): string {
        return "A waiter of sorts.";
    }
}