#import <Foundation/Foundation.h>
#import <ncurses.h>

/*
 *
 * CKConsole
 *
 */
NSString *CKConsoleException = @"CKConsoleException";


@interface CKConsole : NSObject

- (void)startup;
- (void)shutdown;
- (void)setColor:(NSUInteger)color;
- (void)printText:(NSString *)text atX:(NSUInteger)x andY:(NSUInteger)y;
- (void)printChar:(unsigned char)c atX:(NSUInteger)x andY:(NSUInteger)y;
- (void)clear;
- (void)refresh;
- (int)width;
- (int)height;

@end


@implementation CKConsole
{
    WINDOW *_mainwin;
}


- (void)startup
{
    _mainwin = initscr();
    if (_mainwin == NULL) {
        [NSException raise:CKConsoleException format:@"Cannot initialize ncurses"];
    }

    [self initializeColors];
}


- (void)initializeColors
{
    start_color();

    if (has_colors() && COLOR_PAIRS > 13) {
        init_pair(1,  COLOR_RED, COLOR_BLACK);
        init_pair(2,  COLOR_GREEN,   COLOR_BLACK);
        init_pair(3,  COLOR_YELLOW,  COLOR_BLACK);
        init_pair(4,  COLOR_BLUE,    COLOR_BLACK);
        init_pair(5,  COLOR_MAGENTA, COLOR_BLACK);
        init_pair(6,  COLOR_CYAN,    COLOR_BLACK);
        init_pair(7,  COLOR_BLUE,    COLOR_WHITE);
        init_pair(8,  COLOR_WHITE,   COLOR_RED);
        init_pair(9,  COLOR_BLACK,   COLOR_GREEN);
        init_pair(10, COLOR_BLUE,    COLOR_YELLOW);
        init_pair(11, COLOR_WHITE,   COLOR_BLUE);
        init_pair(12, COLOR_WHITE,   COLOR_MAGENTA);
        init_pair(13, COLOR_BLACK,   COLOR_CYAN);
    }
}

- (void)shutdown
{
    delwin(_mainwin);
    endwin();
    refresh();

}

- (void)setColor:(NSUInteger)color
{
    if (color > 13) {
        [NSException raise:CKConsoleException format:@"Specified color %ld is out of range", (unsigned long)color];
    }
    color_set(color, NULL);
}

- (void)clear
{
    erase();
}

- (void)printText:(NSString *)text atX:(NSUInteger)x andY:(NSUInteger)y
{
    mvaddstr(y, x, [text UTF8String]);
}


- (void)printChar:(unsigned char)c atX:(NSUInteger)x andY:(NSUInteger)y
{
    mvaddch(y, x, (chtype)c);
}


- (void)refresh
{
    refresh();
}


- (int)width
{
    return COLS;
}

- (int)height
{
    return LINES;
}


@end



/*
 * CKGrid
 *
 */

@interface CKGrid : NSObject

+ gridWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
- initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
- init;
- (NSUInteger)width;
- (NSUInteger)height;
- (void)displayOnConsole:(CKConsole *)console atX:(NSUInteger)x andY:(NSUInteger)y;
- (void)setValue:(unsigned char)value atX:(NSUInteger)x andY:(NSUInteger)y;
- (unsigned char)getValueAtX:(NSUInteger)x andY:(NSUInteger)y;
- (void)fillWithValue:(unsigned char)c;

@end


@implementation CKGrid
{
    unsigned char *_data;
    NSUInteger _width;
    NSUInteger _height;
}



+ (instancetype)gridWithWidth:(NSUInteger)width andHeight:(NSUInteger)height
{
    return [[self alloc] initWithWidth:width andHeight:height];
}

- (instancetype)initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height
{
    self = [super init];
    if (self) {
        _width = width;
        _height = height;
        _data = (unsigned char*)malloc(_width * _height);

    }
    return self;
}


- (instancetype)init
{
    return [self initWithWidth:8 andHeight:8];
}

- (void)dealloc
{
    free(_data);
}

- (NSUInteger)width
{
    return _width;

}

- (NSUInteger)height
{
    return _height;
}


- (void)fillWithValue:(unsigned char)c
{
    memset(_data, c, sizeof(c) * _width * _height);
}

- (void)displayOnConsole:(CKConsole *)console atX:(NSUInteger)x andY:(NSUInteger)y
{
    NSAssert(x >= 0 && x < _width, @"X out of range ");
    NSAssert(y >= 0 && y < _height, @"Y out of range ");

    for (NSUInteger i = 0; i < _width; i++) {
        for (NSUInteger j = 0; j < _height; j++) {
            unsigned char value = _data[_width * j + i];
            [console printChar:value atX:(i + x) andY:(j + y)];
        }
    }

}

- (void)assertValidX:(NSUInteger)x andY:(NSUInteger)y
{
    NSAssert(x < _width, @"x is out of range");
    NSAssert(y < _height, @"y is out of range");
}


- (void)setValue:(unsigned char)value atX:(NSUInteger)x andY:(NSUInteger)y
{
    [self assertValidX:x andY:y];
    _data[_width * y + x] = value;
}

- (unsigned char)getValueAtX:(NSUInteger)x andY:(NSUInteger)y
{
    [self assertValidX:x andY:y];
    return _data[_width * y + x];
}

@end


/**
 *
 * Board
 */

#define CELL_ALIVE '@'
#define CELL_DEAD '.'


@interface CKBoard : NSObject

+ (instancetype)boardWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
- (instancetype)initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
- (CKGrid *)makeGridWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
- (void)clearCellsOnGrid:(CKGrid *)grid;
- (void)generateRandomCells:(NSUInteger)count onGrid:(CKGrid *)grid;
- (NSUInteger)countCellsNeighboursOnGrid:(CKGrid *)grid atX:(NSUInteger)x andY:(NSUInteger)y;
- (void)nextGeneration;

@end



@implementation CKBoard
{
    CKGrid *_grid;
}

+ (instancetype)boardWithWidth:(NSUInteger)width andHeight:(NSUInteger)height
{
    return [[self alloc] initWithWidth:width andHeight:height];
}


- (instancetype)initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height
{
    self = [super init];

    if (self) {
        _grid = [self makeGridWithWidth:width andHeight:height];
        [self clearCellsOnGrid:_grid];
    }
    return self;
}


- (CKGrid *)makeGridWithWidth:(NSUInteger)width andHeight:(NSUInteger)height
{
    CKGrid *result = [CKGrid gridWithWidth:width andHeight:height];
    return result;
}

- (void)clearCellsOnGrid:(CKGrid *)grid
{
    [grid fillWithValue:CELL_DEAD];
}

- (void)generateRandomCells:(NSUInteger)count onGrid:(CKGrid *)grid
{
    NSUInteger width = [grid width];
    NSUInteger height = [grid height];

    for (NSUInteger i = 0; i < count; i++) {

        NSUInteger x =  arc4random() % width;
        NSUInteger y = arc4random() % height;
        [grid setValue:CELL_ALIVE atX:x andY:y];
    }
}


- (void)generateRandomCells:(NSUInteger)count
{
    [self generateRandomCells:count onGrid:_grid];
}

- (NSUInteger)countCellsNeighboursOnGrid:(CKGrid *)grid atX:(NSUInteger)x andY:(NSUInteger)y
{
    NSUInteger width = [grid width];
    NSUInteger height = [grid height];

    NSUInteger result = 0;
    for (NSInteger i = x - 1; i <= x + 1; i++) {
        for (NSInteger j = y - 1; j <= y + 1; j++) {
            if (i >= 0 && i < width && j >= 0 && j < height) {
                unsigned char value = [grid getValueAtX:i andY:j];
                if (value == CELL_ALIVE) {
                    result++;
                }
            }
        }
    }
    return result;
}


- (void)nextGeneration
{
    NSUInteger width = [_grid width];
    NSUInteger height = [_grid height];


    CKGrid *newGrid = [self makeGridWithWidth:width andHeight:height];
    [self clearCellsOnGrid:newGrid];


    // Rules:
    // Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    // Any live cell with two or three live neighbours lives on to the next generation.
    // Any live cell with more than three live neighbours dies, as if by overcrowding.
    // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

    for (NSUInteger x = 0; x < width; x++) {
        for (NSUInteger y = 0; y < height; y++) {
            unsigned char oldValue = [_grid getValueAtX:x andY:y];
            unsigned char newValue = CELL_DEAD;

            NSUInteger neighboursCount = [self countCellsNeighboursOnGrid:_grid atX:x andY:y];

            if (oldValue) {
                if (neighboursCount == 2 || neighboursCount == 3) {
                    newValue = CELL_ALIVE;
                }
            } else {
                if (neighboursCount == 3) {
                    newValue = CELL_ALIVE;
                }
            }
            [newGrid setValue:newValue atX:x andY:y];
        }
    }

    _grid = newGrid;
}



- (void)displayOnConsole:(CKConsole *)console atX:(NSUInteger)x andY:(NSUInteger)y
{
    [_grid displayOnConsole:console atX:x andY:y];
}

@end


/**
 *  CKCodeKta
 */

@interface CKCodeKata : NSObject
- (void)run;
@end

@implementation CKCodeKata

- (void)run
{
    CKConsole *console = [CKConsole new];
    CKBoard *board = [CKBoard boardWithWidth:50 andHeight:20];

    [console startup];
    @try {

        [board generateRandomCells:20];
        [board displayOnConsole:console atX:5 andY:5];

        [console refresh];

        for (NSUInteger i = 0; i < 10; i++) {
            sleep(425);
        }
    } @finally {
        [console shutdown];
    }

}
@end




/*
 * Main application
 *
 */


int main(int argc, const char * argv[])
{

    @autoreleasepool {

        CKCodeKata *kata = [CKCodeKata new];
        [kata run];


        return 0;
    }
}
