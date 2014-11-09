#import <Foundation/Foundation.h>

/*
 Utility functions
 */

void CKPrint(NSString *format, ...)
{
    va_list args;
    va_start(args, format);

    NSString *s = [[NSString alloc] initWithFormat:format arguments:args];
    fputs([s UTF8String], stdout);
    fputs("\n", stdout);
    va_end(args);
}


NSString *CKReadLine(NSString *prompt)
{
    NSFileHandle *fileHandle = [NSFileHandle fileHandleWithStandardInput];
    NSData *inputData;
    NSString *inputString;
    printf("%s", [prompt UTF8String]);

    inputData = [fileHandle availableData];

    inputString = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
    inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];


    return inputString;

}

//
// CKBrailleTranslator
//

@interface CKBrailleTranslator : NSObject
- (NSString *)translateToBrailleFromAscii:(NSString *)asciiText;
- (NSString *)translateToAsciiFromBraille:(NSString *)brailleText;
@end

@implementation CKBrailleTranslator
{
    NSMutableDictionary *_asciiToBraille;
    NSMutableDictionary *_brailleToAscii;

}

const char *BRAILLE_DEFINITIONS =
                "ao....."
                "bo.o..."
                "coo...."
                "doo.o.."
                "eo..o.."
                "fooo..."
                "goooo.."
                "ho.oo.."
                "i.oo..."
                "j.ooo.."
                "ko...o."
                "lo.o.o."
                "moo..o."
                "noo.oo."
                "oo..oo."
                "pooo.o."
                "ro....."
                "s......"
                "t......"
                "u......"
                "v......"
                "x......"
                "y......"
                "z......" ;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _asciiToBraille = [NSMutableDictionary dictionary];
        _brailleToAscii = [NSMutableDictionary dictionary];
        [self initializeAsciiToBrailleDictionary:_asciiToBraille
                        brailleToAsciiDictionary:_brailleToAscii
                                       withInput:[NSString stringWithUTF8String:BRAILLE_DEFINITIONS]];

    }
    return self;
}




- (void)initializeAsciiToBrailleDictionary:(NSMutableDictionary *)asciiToBraille
                  brailleToAsciiDictionary:(NSMutableDictionary *)brailleToAscii
                                 withInput:(NSString *)input
{
    [asciiToBraille removeAllObjects];
    [brailleToAscii removeAllObjects];

    brailleToAscii[@"a"] = @".oooo..o";

}

- (NSString *)translateToBrailleFromAscii:(NSString *)asciiText
{
    size_t length = [asciiText lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    unichar *characters = malloc(length * sizeof(unichar));

    [asciiText getCharacters:characters];


    for (NSUInteger i = 0; i < length; i++) {
        CKPrint(@"Character is %C", characters[i]);
    }

    free(characters);
    return @"DONE";

}

- (NSString *)translateToAsciiFromBraille:(NSString *)brailleText
{
    size_t length = [brailleText lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    unichar *characters = malloc(length + sizeof(unichar));

    [brailleText getCharacters:characters];

    for (NSUInteger i = 0; i < length; i++) {
        CKPrint(@"Character is %C", characters[i]);
    }

    free(characters);

    return @"DONE";

}

@end



//
// CKCodeKata
//

@interface CKCodeKata : NSObject

- (void)run;
@end

@implementation CKCodeKata

- (void)run
{

    CKPrint(@"Hello world");
    CKPrint(@"This is some braille code ... ");

    CKBrailleTranslator *translator = [CKBrailleTranslator new];

    NSString *ascii = [translator translateToAsciiFromBraille:@"o.oo..o. o..o..o"];

    [translator translateToBrailleFromAscii:@"Lazy fox jumps over brown dog"];

    CKPrint(@"Ascii translation %@", ascii);
}

@end



int main(int argc, const char * argv[])
{

    @autoreleasepool {
        CKCodeKata *kata = [CKCodeKata new];
        [kata run];

    }

    return 0;
}
