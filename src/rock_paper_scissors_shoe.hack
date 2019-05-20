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