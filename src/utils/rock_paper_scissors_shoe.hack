namespace RockPaperScissorsShoe;

enum MOVES: int {
    ROCK = 0;
    PAPER = 1;
    SCISSORS = 2;
}

enum RESULTS: int {
    LOSE = -1;
    TIE = 0;
    WIN = 1;
}

function genMove(): MOVES {
    return \rand(0, 3);
}

function getResult(MOVES $player1,
    MOVES $player2): RESULTS {
    if ($player1 === MOVES::ROCK) {
        if ($player2 === MOVES::ROCK) {
            return RESULTS::TIE;
        } elseif ($player2 === MOVES::PAPER) {
            return RESULTS::LOSE;
        }
        return RESULTS::WIN;
    } elseif ($player1 === MOVES::PAPER) {
        if ($player2 === MOVES::PAPER) {
            return RESULTS::TIE;
        } elseif ($player2 === MOVES::SCISSORS) {
            return RESULTS::LOSE;
        }
        return RESULTS::WIN;
    }
    if ($player2 === MOVES::SCISSORS) {
        return RESULTS::TIE;
    } elseif ($player2 === MOVES::ROCK) {
        return RESULTS::LOSE;
    }
    return RESULTS::WIN;
}

function queryPlayerMove(): MOVES {
    echo "What would you like to play?\n" .
        "(a) Rock.\n" . 
        "(b) Paper.\n" .
        "(c) Scissors.\n";
    
    $choice = \readline('');

    if ($choice === "a") {
        return MOVES::ROCK;
    } elseif ($choice === "b") {
        return MOVES::PAPER;
    } elseif ($choice === "c") {
        return MOVES::SCISSORS;
    } else {
        echo "You don't know what you're doing and make some sort of fist.\n";
        return MOVES::ROCK;
    }
}