namespace People;

use namespace HH\Lib\Vec;

require_once(__DIR__."/npc.hack");
require_once(__DIR__."/player.hack");
require_once(__DIR__."/../utils/rock_paper_scissors_shoe.hack");

class Woman implements \People\NPC {
    private static bool $hasBeenCheated = false;
    private static int $convProgress = 0;

    private static function announceMove(\RockPaperScissorsShoe\MOVES $move): void {
        echo "She plays " . \RockPaperScissorsShoe\MOVES::getNames()[$move] . ".\n";
    }

    public static function playRockPaperScissorsShoe(): bool {
        $res = \RockPaperScissorsShoe\RESULTS::TIE;

        while ($res === \RockPaperScissorsShoe\RESULTS::TIE) {
            $player1 = \RockPaperScissorsShoe\queryPlayerMove();
            $player2 = \RockPaperScissorsShoe\genMove();
            $res = \RockPaperScissorsShoe\getResult($player1, $player2);

            self::announceMove($player2);
        }
        if ($res === \RockPaperScissorsShoe\RESULTS::WIN) {
            echo "You win, I suppose.\n";

            return true;
        };
        echo "Defeated.\n";

        return false;
    }

    public static function playFakeRockPaperScissorsShoe(): bool {
        $player2 = \RockPaperScissorsShoe\genMove();

        self::announceMove($player2);
        echo "\"Wait, why haven't you made your move yet?\"\n" . 
            "She looks at you, irritated.\n";

        $player1 = \RockPaperScissorsShoe\queryPlayerMove();
        $res = \RockPaperScissorsShoe\getResult($player1, $player2);

        if ($res === \RockPaperScissorsShoe\RESULTS::WIN) {
            echo "\"You're not winning by that method again.\"\n";

            return true;
        };
        echo "\"I'm not sure how you lost. Err, keep your pound.\"\n";

        return false;
    }

    public static function speak(): void {
        if (self::$convProgress < 5) {
            echo "The woman turns towards you with bored expectation.\n" .
                "She looks about your age, but you know better than to ask.\n";
        } elseif (self::$convProgress < 9) {
            echo "The woman you are attempting to marry looks towards you\n" .
                "with mixed amusement and self-concern.\n";
        } else {
            echo "It's your wife. Neat!\n";
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
            echo "  (b) Maintain eye contact casually.\n";
        } elseif (self::$convProgress < 4) {
            echo "  (b) \"Marry me.\"\n";
        } elseif (self::$convProgress < 5) {
            echo "  (b) \"Serious.\"\n";
        } elseif (self::$convProgress < 6) {
            $money = \People\Player::getMoney();

            echo "  (b) \"I have " . \People\Player::pluralizeMoney($money) . ".\"\n";
        } elseif (self::$convProgress < 7) {
            echo "  (b) \"An immediate marriage.\"\n";
        } elseif (self::$convProgress < 8) {
            echo "  (b) Borrow one of her rings.\n";
        } elseif (self::$convProgress < 9) {
            echo "  (b) \"What's your name?\"\n";
        } elseif (\People\Player::hasItem(\People\Player\ITEMS::MARRIAGE_WITH_ICELANDER)) {
            echo "  (b) \"So we're married, Charlotte?\"\n";
        } else {
            echo "  (b) \"What do you do?\"\n";
        }

        $choice = \readline('');

        if ($choice === "a") {
            if (self::$hasBeenCheated) {
                if (self::playRockPaperScissorsShoe()) {
                    \People\Player::addMoney(1);
                } else {
                    \People\Player::removeMoney(1);
                }
            } else {
                echo "She stares at you for a prolonged period and then puts a single pound on the table.\n" .
                    "\"If you win, you get this. If I win, you give me one.\"\n";
                if (self::playFakeRockPaperScissorsShoe()) {
                    \People\Player::addMoney(1);
                }
                self::$hasBeenCheated = true;
            }
        } elseif ($choice === "b") {
            if (self::$convProgress < 1) {
             echo "\"I imagine things are going to get turbulent soon.\"\n" .
                "She smiles as if she's just blown the candles off someone else's birthday cake.\n";
                self::$convProgress++;
            } elseif (self::$convProgress < 2) {
                if (\People\Player::hasItem(\People\Player\ITEMS::COOKIE)
                    || \People\Player::hasItem(\People\Player\ITEMS::TEA)) {
                    echo "\"Well... It's secret.\"\n";
                    self::$convProgress++;
                } else {
                    echo "\"It's complicated...\n" .
                        "You should buy something before they kick you out.\"\n";
                }
            } elseif (self::$convProgress < 3) {
                \readline("\"Oh, I suppose it doesn't matter. Not much anyone can do about it now.\"");
                \readline("\"There's an Icelandic invasion occuring.\"");
                \readline("\"What?\" You feel mild perturbation.");
                \readline("\"Oh yes, we've been planning it for some time.\"");
                \readline("\"You are... an Icelander?\"");
                \readline("\"It would appear I am.\" She seems to be growing bored with you.");
                self::$convProgress++;
            } elseif (self::$convProgress < 4) {
                \People\Player::addItem(\People\Player\ITEMS::DESIRE_TO_MARRY_ICELANDER);
                echo("She wishes to express her bafflement publicly, but there's no one around but the magistrate.\n" .
                    "\"Serious?\"\n");
                self::$convProgress++;
            } elseif (self::$convProgress < 5) {
                \readline("\"Isn't this a bit fast?\" she responds very reasonably.");
                \readline("\"No,\" you respond less reasonably.");
                \readline("The Icelandic woman thinks a moment...");
                \readline("\"Do you think being married to me will save you from the invasion?\"");
                \readline("You make a single enthusiastic nod.");
                \readline("\"That's understandable, but there's so little I know about you...\" she trails off.");
                self::$convProgress++;
            } elseif (self::$convProgress < 6) {
                \readline("\"Impressive,\" she speaks cooly.");
                \readline("\"If we were to get married, when would it be?\"");
                self::$convProgress++;
            } elseif (self::$convProgress < 7) {
                if (\People\Player::hasItem(\People\Player\ITEMS::MAGISTRATE_PHONE)) {
                    echo "You show her the magistrate's phone with evidence of his ability to legalize marriages.\n";

                    if (\People\Player::hasItem(\People\Player\ITEMS::FAX_MACHINE_ACCESS)) {
                        echo "You inform her marriage is imminent.\n" . 
                            "She replies that you don't even have a ring to give her.\n";
                        self::$convProgress++;
                    } else {
                        echo "\"How will you get the documents to town hall?\"\n";
                    }
                } else {
                    echo "\"Who will perform the marriage?\"\n";
                }
            } elseif (self::$convProgress < 8) {
                \People\Player::addItem(\People\Player\ITEMS::RING);
                \readline("You slide one of her rings off her finger and put it in your pocket.");
                \readline("Your future wife gapes at you.");
                \readline("\"Stealing my ring to give back to me is a bold move.\"");
                \readline("You nod agreeably. Marriage is all but assured.");
                \readline("\"But do you even know my name?\"");
                self::$convProgress++;
            } elseif (self::$convProgress < 9) {
                if (\People\Player::hasItem(\People\Player\ITEMS::NAME)) {
                    \readline("\"Charlotte.\"");
                    \readline("You propose to Charlotte.");
                    \readline("For some reason, she says yes.");
                    self::$convProgress++;
                } else {
                    echo "\"You want to know my name?\n" .
                        "Do you even know your name?\"\n";
                    \People\Player::addItem(\People\Player\ITEMS::DESIRE_TO_KNOW_NAME);
                }
            } elseif (\People\Player::hasItem(\People\Player\ITEMS::MARRIAGE_WITH_ICELANDER)) {
                echo "\"Allegedly.\"\n";
            } else {
                echo "\"I am an accountant.\"\n";
            }
        } else {
            echo "She rolls her eyes at your incoherent babble.\n";
        }
    }
}