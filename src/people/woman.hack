namespace People;

use namespace HH\Lib\Vec;

require_once(__DIR__."/npc.hack");
require_once(__DIR__."/player.hack");
require_once(__DIR__."/../rock_paper_scissors_shoe.hack");

class Woman implements \People\NPC {
    private static bool $hasBeenCheated = false;
    private static int $convProgress = 0;

    private static function announceMove(\RockPaperScissorsShoe\MOVES $move): void {
        echo "She plays " . $move . "\n.";
    }

    public static function genRockPaperScissorsShoeMove(): \RockPaperScissorsShoe\MOVES {
        $move = \rand(0, 3);

        if (!self::$hasBeenCheated) {
            self::$hasBeenCheated = true;
            $moveStr = Vec\keys(\RockPaperScissorsShoe\MOVES::getNames())[$move];

            self::announceMove($moveStr);
            echo "\"Wait, why haven't you made your move yet?\"\n" . 
                "She looks at you, irritated.\n";
        }
        return $move;
    }

    public static function playRockPaperScissorsShoe(
        \RockPaperScissorsShoe\MOVES $player1): bool {
        $res = \RockPaperScissorsShoe\RESULTS::TIE;

        while ($res === \RockPaperScissorsShoe\RESULTS::TIE) {
            $move = self::genRockPaperScissorsShoeMove();
            $res = \RockPaperScissorsShoe\getResult($player1, $move);

            self::announceMove($move);
        }
        if ($res === \RockPaperScissorsShoe\RESULTS::WIN) {
            echo "You win, I suppose.\n";

            return true;
        };
        echo "Defeated.\n";

        return false;
    }

    public static function speak(): void {
        if (self::$convProgress < 3) {
            echo "The woman turns towards you with bored expectation.\n" .
                "She looks about your age, but you know better than to ask.\n";
        }
        echo "What do you say?\n" .
            "  (a) \"I would like to play Rock Paper Scissors Shoe with you for money.\"\n";
        if (self::$convProgress < 1) {
             echo "  (b) \"How about politics?\"\n";
        } elseif (self::$convProgress < 2) {
             echo "  (b) \"'Turbulent?'\"";

             if (\People\Player::hasItem(\People\Player\ITEMS::COOKIE)) {
                 echo " Nibble your cookie with intrigue.";
             } elseif (\People\Player::hasItem(\People\Player\ITEMS::TEA)) {
                 echo " Sip your tea as if it doesn't sound important.";
             }
             echo "\n";
        } elseif (self::$convProgress < 3) {
            echo "  (b) \"Marry me.\"\n";
        } elseif (self::$convProgress < 4) {
            echo "  (b) \"Seriously.\"\n";
        } elseif (self::$convProgress < 5) {
            $money = \People\Player::getMoney();

            echo "  (b) \"I have " . \People\Player::pluralizeMoney($money) . ".\"\n";
        } elseif (self::$convProgress < 6) {
            echo "  (b) \"Right now.\"\n";
        } elseif (self::$convProgress < 7) {
            echo "  (b) Borrow one of her rings.\n";
        }
    }
}