namespace People;

class Waiter {
    private static int $annoyance = 5;

    private static function brood(): void {
        self::$annoyance++;
    }

    public static function sellFood(): void {
        self::$annoyance -= 15;
    }

    public static function shouldKickOut(): bool {
        self::brood();
        
        if (self::$annoyance >= 20) {
            self::speak();

            return true;
        }
        return false;
    }

    public static function speak(): void {
        if (self::$annoyance < 1) {
            echo "\"Delightful patron, I rejoice at your presence before me.\"";
        } elseif (self::$annoyance < 5) {
            echo "\"Anything I can help you with?\"";
        } elseif (self::$annoyance < 10) {
            echo "\"It's been a while, can I get you anything?\"";
        } elseif (self::$annoyance < 15) {
            echo "\"It's a bit busy, and if you're done eating, we could use the table.\"";
        } elseif (self::$annoyance < 18) {
            echo "\"An ill-mannered, saucy fellow thou art.\"";
        } elseif (self::$annoyance < 20) {
            echo "\"Horswoggling fungus.\"";
        } else {
            echo "The waiter suddenly bears down on you.
             \"I'm sorry, but it's been hours since you've ordered anything,
             and we need this table for other customers.\"";
        }
        
    }

    public function __toString(): string {
        return "A waiter of sorts.";
    }
}