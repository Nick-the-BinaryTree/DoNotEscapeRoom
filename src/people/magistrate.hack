namespace People;

require_once(__DIR__."/npc.hack");
require_once(__DIR__."/player.hack");

class Magistrate implements \People\NPC {
    private static int $convProgress = 0;

    public static function speak(): void {
        if (self::$convProgress < 2) {
            echo "The magistrate has a mustache you would expect.\n";
        } elseif (self::$convProgress < 4) {
            echo "The magistrate gives you a good-natured smile.\n";
        } else {
            echo "The magistrate watches the news on the television.\n";
        }
        echo "What do you say?\n";
        
        if (self::$convProgress < 1) {
            echo "  (a) \"So you are the magistrate.\"\n" .
                "  (b) \"What is your name?\"\n";
        } elseif (self::$convProgress < 2) {
            echo "  (a) \"What is your job like?\"\n" .
                "  (b) \"Any news about the town?\"\n";
        } elseif (self::$convProgress < 3) {
            echo "  (a) \"I like this room a lot.\"\n";

            if (\People\Player::hasItem(\People\Player\ITEMS::DESIRE_TO_MARRY_ICELANDER)) {
                echo "  (b) \"Can you marry me to the woman behind us?\"\n";
            }
        } elseif (self::$convProgress < 4) {
            echo "  (a) \"What is your take on Iceland?\"\n";

            if (\People\Player::hasItem(\People\Player\ITEMS::FAX_MACHINE_ACCESS)) {
                echo "  (b) \"Let's proceed with the marriage.\"\n";
            }
        } else {
            echo "  (a) \"What are you thinking about?\"\n" .
                "  (b) \"I like you.\"\n";
        }

        $choice = \readline('');

        if ($choice !== "a" && $choice !== "b") {
            echo "You have to be more clear about what you're saying.\n";
            return;
        }

        if (self::$convProgress < 1) {
            if ($choice === "a") {
                echo "\"Yes, I am the magistrate.\n" .
                    "I meet most people in this town at some point.\"\n";
                self::$convProgress++;
            } else {
                echo "\"Trevor.\"\n";
            }
        } elseif (self::$convProgress < 2) {
            if ($choice === "a") {
                echo "\"I serve as a judiciary for minor cases.\n" .
                    "I also became ordained on the internet to officiate weddings.\"\n";
                self::$convProgress++;
            } else {
                echo "\"None really. I grew a potato in my home garden.\"\n";
            }
        } elseif (self::$convProgress < 3) {
            if ($choice === "a") {
                echo "\"It is a nice room.\"\n";
            } elseif (\People\Player::hasItem(\People\Player\ITEMS::DESIRE_TO_MARRY_ICELANDER)) {
                echo "His eyes light up.\n" . 
                    "\"I haven't had a chance to use my certificate yet. That would be fun.\"\n" .
                    "He hands you his phone with an official looking document\n" .
                    "authorizing him to perform marriages on the screen.\n";
                \People\Player::addItem(\People\Player\ITEMS::MAGISTRATE_PHONE);
                self::$convProgress++;
            }
        } elseif (self:: $convProgress < 4) {
            if ($choice === "a") {
                echo "\"Hmm... they've always seemed nice. Telly says they've seized the capital.\"\n";
            } elseif (\People\Player::hasItem(\People\Player\ITEMS::FAX_MACHINE_ACCESS)) {
                \readline("The magistrate takes a folder out of his leather satchel and sorts through some papers.");
                \readline("You take Charlotte's hand.");
                \readline("The magistrate finds the documents he's looking for.");
                \readline("You shimmy the ring back into its former position on Charlotte's finger.");
                \readline("The magistrate places the forms on the bar.");
                \readline("Charlotte is analyzing you.");
                \readline("The magistrate adjusts his glasses.");
                \readline("You're telling Charlotte about your passion for poetry.");
                \readline("The magistrate hands you both pens.");
                \readline("You sign. Charlotte signs.");
                \readline("The magistrate looks over the signatures.");
                \readline("Charlotte tells you she wants to go on honeymoon in Costa Rica.");
                \readline("The magistrate hands the papers over to you.");
                \readline("You call the waiter over and ask him to fax the marriage officiation to town hall.");
                \readline("You're married.");

                \People\Player::removeItem(\People\Player\ITEMS::MAGISTRATE_PHONE);
                \People\Player::removeItem(\People\Player\ITEMS::DESIRE_TO_MARRY_ICELANDER);
                \People\Player::addItem(\People\Player\ITEMS::MARRIAGE_WITH_ICELANDER);
                self::$convProgress++;
            }
        } else {
            if ($choice === "a") {
                echo "\"The deterioration of the middle class.\"\n";
            } else {
                echo "\"I believe I just wed you to someone else.\"\n";
            }
        }
    }
}