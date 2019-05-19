#!/usr/bin/env hhvm

require_once(__DIR__.'/../vendor/autoload.hack');
require_once(__DIR__.'/../src/game.hack');

<<__EntryPoint>>
async function main(): Awaitable<noreturn> {
    \Facebook\AutoloadMap\initialize();

    \Game\startGame();

    exit(0);
}