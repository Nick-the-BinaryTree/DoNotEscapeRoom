namespace People\Player {
    enum ITEMS: string {
        COOKIE = "Cookie";
        DESIRE_TO_KNOW_NAME = "Desire to Know Name";
        DESIRE_TO_MARRY_ICELANDER = "Desire to Marry Icelander";
        FAX_MACHINE_ACCESS = "Fax Machine Access";
        MAGISTRATE_PHONE = "Magistrate's Phone";
        MARRIAGE_WITH_ICELANDER = "Marriage with Icelander";
        NAME = "Name";
        POEM = "Poem";
        RING = "Ring";
        TEA = "Tea";
    }
}

namespace People {
    use namespace HH\Lib\{C, Keyset, Str};

    class Player {
        private static keyset<\People\Player\ITEMS> $items = keyset[];
        private static int $money = 0;
        
        public static ?string $name;

        public static function pluralizeMoney(int $money): string {
            return $money . " pound" . ($money === 1 ? "" : "s");
        }

        public static function describe(): void {
            echo "Your name is " . self::getName() . ".\n";
            echo "You have " . self::pluralizeMoney(self::$money) . "\n";

            if (C\count(self::$items) > 0) {
                echo "Items: " . Str\join(self::$items, ' | ');
            } 
            
            echo "\n";
        }

        public static function getName(): string {
            return self::$name ?? "...that's odd, you don't recall";
        }

        public static function setName(string $name): void {
            self::$name = $name;
        }

        public static function addItem(\People\Player\ITEMS $item): void {
            self::$items[] = $item;
        }

        public static function hasItem(\People\Player\ITEMS $item): bool {
            return C\contains_key(self::$items, $item);
        }

        public static function removeItem(\People\Player\ITEMS $item): void {
            self::$items = Keyset\filter(self::$items, $x ==> $x !== $item);

        }

        public static function addMoney(int $amount): void {
            if ($amount > 0) {
                self::$money += $amount;
                echo "\n*You got " . self::pluralizeMoney($amount) . "!\n";
            }
        }

        public static function getMoney(): int {
            return self::$money;
        }

        public static function removeMoney(int $amount): void {
            if ($amount > 0) {
                self::$money -= $amount;
                echo "\n*You lost " . self::pluralizeMoney($amount) . ".\n";
            }
        }

        public function __toString(): string {
            return "Just this guy.";
        }
    }
}
