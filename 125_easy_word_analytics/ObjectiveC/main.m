#import <Foundation/Foundation.h>

// Utility classes

NSString *inspect(id obj)
{
    if ([obj isKindOfClass:[NSCharacterSet class]]) {
        NSCharacterSet *this = obj;
        NSMutableString *result = [NSMutableString string];
        for (unichar uc = 0x0; uc < 0xFFFF; uc++) {
            if ([this characterIsMember:uc]) {
                [result appendFormat:@"%C", uc];
            }

        }
        return result;

    } else {
        return [obj description];
    }
}



/*
Number of words
Number of letters
Number of symbols (any non-letter and non-digit character, excluding white spaces)
Top three most common words (you may count "small words", such as "it" or "the")
Top three most common letters
Most common first word of a paragraph (paragraph being defined as a block of text with an empty line above it) (Optional bonus)
Number of words only used once (Optional bonus)
All letters not used in the document (Optional bonus)
*/


@interface CKAnalysisResult : NSObject

@property (nonatomic) NSUInteger numberOfLetters;
@property (nonatomic) NSUInteger numberOfSymbols;
@property (nonatomic, copy) NSArray *mostCommonWords;
@property (nonatomic, copy) NSArray *mostCommonLetters;
@property (nonatomic, copy) NSString *mostCommonFirstWordOfParagraph;
@property (nonatomic) NSUInteger numberOfWordsUsedOnce;
@property (nonatomic, copy) NSCharacterSet *lettersNotUsedInDocument;
@property (nonatomic) NSUInteger numberOfLettersNotUsedInDocument;

@end

@implementation CKAnalysisResult

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberOfLetters = 0;
        self.numberOfSymbols = 0;
        self.mostCommonWords = [NSMutableArray array];
        self.mostCommonLetters = [NSMutableArray array];
        self.mostCommonFirstWordOfParagraph = @"";
        self.numberOfWordsUsedOnce = 0;
        self.lettersNotUsedInDocument = [NSMutableCharacterSet characterSetWithCharactersInString:@""];
        self.numberOfLettersNotUsedInDocument = 0;
    }

    return self;
}

- (NSString *)description
{
    NSMutableString *result = [NSMutableString string];
    [result appendString:@"Analysis Result:\n"];
    [result appendFormat:@"Number of letters: %d\n", self.numberOfLetters];
    [result appendFormat:@"Number of symbols: %d\n", self.numberOfSymbols];
    [result appendFormat:@"Most common words: %@\n", self.mostCommonWords];
    [result appendFormat:@"Most common letters: %@\n", self.mostCommonLetters];
    [result appendFormat:@"Most common first word of paragraph: %@\n", self.mostCommonFirstWordOfParagraph];
    [result appendFormat:@"Number of words used once: %d\n", self.numberOfWordsUsedOnce];
    [result appendFormat:@"Letters not used in document: %@\n", self.lettersNotUsedInDocument];
    [result appendFormat:@"Number of letters not used in document: %d\n", self.numberOfLettersNotUsedInDocument];

    return result;
}

@end




@interface CodeKata : NSObject
- (void)run:(NSArray *)arguments;

@end


@implementation CodeKata

- (CKAnalysisResult *)analyzeText:(NSString *)text
{
    NSMutableSet *set = [NSMutableSet set];

    NSMutableCharacterSet *unusedChars = [NSMutableCharacterSet alphanumericCharacterSet];

    CKAnalysisResult *result = [[CKAnalysisResult alloc] init];

    size_t textLength = [text length];
    unichar *buffer = (unichar *)malloc(textLength);

    result.numberOfLetters = textLength;

    [text getCharacters:buffer];
    for (NSUInteger i = 0; i < textLength; i++) {
        unichar c = buffer[i];
        if (c == ' ') {
            result.numberOfSymbols++;
        }

        if ([unusedChars characterIsMember:c]) {
            [unusedChars removeCharactersInString:[NSString stringWithFormat:@"%c", c]];
        }
    }

    result.lettersNotUsedInDocument = unusedChars;
    free(buffer);

    return result;
}

- (void)run:(NSArray *)arguments
{
    NSLog(@"CodeKata START ----");

    NSLog(@"Got arguments count %d", [arguments count]);

    NSUInteger i = 0;
    for (NSString *argument in arguments) {
        NSLog(@"Got argument %@", argument);
        i++;

        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:argument]) {
            NSLog(@"File does not exist, skipping ");
            continue;
        }

        NSError *error = nil;
        NSString *text = [NSString stringWithContentsOfFile:argument encoding:NSUTF8StringEncoding
                                                      error:&error];
        if (error) {
            NSLog(@"Error occurred %@, skipping ... ", error);
            continue;
        }

        CKAnalysisResult *result = [self analyzeText:text];

        NSLog(@"%@", result);

    }
    NSLog(@"CodeKata STOP ----");

}


@end



void test_char_set()
{
//    NSMutableCharacterSet *mset = [NSMutableCharacterSet characterSetWithCharactersInString:@"abcdefX01"];
//
//    NSLog(@"%@", inspect(mset));
//
//    NSCharacterSet *set = [NSCharacterSet alphanumericCharacterSet];
//    NSLog(@"%@", inspect(set));
//    NSLog(@"%@", inspect([NSCharacterSet decimalDigitCharacterSet]));
    NSLog(@"%@", inspect([NSCharacterSet capitalizedLetterCharacterSet]));

}


int main(int argc, const char * argv[])
{

    @autoreleasepool {

//        NSString *inputPath = @"/Users/afolmert/Desktop/CodeKatas/DailyProgrammer/125_easy_word_analytics/ObjectiveC"
//                "/CodeKata/CodeKata/input.txt";
//
//        CodeKata *kata = [[CodeKata alloc] init];
//        [kata run:@[inputPath]];

        test_char_set();

    }

    return 0;
}
