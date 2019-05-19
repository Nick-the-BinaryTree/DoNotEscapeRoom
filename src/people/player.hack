namespace People;

require_once(__DIR__."/../items.hack");

use namespace HH\Lib\{C, Keyset, Str};

class Player {
    private static ?string $name;
    private static keyset<\Items\ITEMS> $items = keyset[];
    private static int $money = 0;

    public static function describe(): void {
        echo "Your name is " . self::getName() . ".\n";
        echo "You have " . self::$money . " bitcoin.\n";

        if (C\count(self::$items) > 0) {
            echo "Items: " . Str\join(self::$items, ' | ');
        } 
        
        echo "\n";
    }

    public static function getName(): string {
        return self::$name ?? "...that's odd. You don't recall";
    }

    public static function setName(string $name): void {
        self::$name = $name;
    }

    public static function addItem(\Items\ITEMS $item): void {
        self::$items[] = $item;
    }

    public static function hasItem(\Items\ITEMS $item): bool {
        return C\contains_key(self::$items, $item);
    }

    public static function removeItem(\Items\ITEMS $item): void {
        self::$items = Keyset\filter(self::$items, $x ==> $x === $item);
    }

    public static function addMoney(int $amount): void {
        if ($amount > 0) {
            self::$money += $amount;
        }
    }

    public static function getMoney(): int {
        return self::$money;
    }

    public static function removeMoney(int $amount): void {
        if ($amount > 0) {
            self::$money -= $amount;
        }
    }

    public function __toString(): string {
        return "Just this guy.";
    }
}