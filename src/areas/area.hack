namespace Areas;

enum AREAS: string {
    BAR = 'Bar';
    CORNER = 'Corner';
    TABLE = 'Table';
}

interface Area {
    public static function queryPlayer(): bool;
}