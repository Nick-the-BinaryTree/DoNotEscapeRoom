namespace Areas;

require_once(__DIR__."/area.hack");
require_once(__DIR__."/../people/magistrate.hack");
require_once(__DIR__."/../people/player.hack");
require_once(__DIR__."/../people/woman.hack");

class Bar implements \Areas\Area {
    public static function queryPlayer(): bool {
        return true;
    }
}