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


/*
 * NSArray additions
 */

@interface NSArray (CKUtilities)

- (NSArray *)arrayByReversing;

@end

@implementation NSArray (CKUtilities)

- (NSArray *)arrayByReversing
{
    NSMutableArray *result = [NSMutableArray array];
    NSUInteger count = [self count];

    for (NSInteger i = count - 1; i >= 0; i--) {
        [result addObject:self[i]];
    }

    return result;

}

@end

/*
 * NSString utilities
 */

@interface NSString (CKUtilities)

- (NSString *)stringByCenteringInWidth:(NSUInteger)width;

@end

@implementation NSString (CKUtilities)

- (NSString *)stringByCenteringInWidth:(NSUInteger)width withCharacter:(unichar)c
{
    if ([self length] >= width) {
        return self;
    } else {
        NSString *padding = [NSString stringWithFormat:@"%c", c];
        NSMutableString *result = [NSMutableString string];

        NSUInteger l = (width - [self length]) / 2;
        [result appendString:[@"" stringByPaddingToLength:l
                withString:padding startingAtIndex:0]];
        [result appendString:self];
        result = [result stringByPaddingToLength:width withString:padding
                                 startingAtIndex:0];
        return result;
    }

}

@end


/*
 * CKCodeKata
 *
 */


@interface CKCodeKata : NSObject

- (void)run:(NSString *)input;

@end


@implementation CKCodeKata

- (void)run:(NSString *)input
{

    NSArray *inputComponents = [input componentsSeparatedByString:@" "];

    NSUInteger baseNumber = [inputComponents[0] intValue];
    NSString *trunkChar = inputComponents[1];
    NSString *leafChar = inputComponents[2];


    // build the tree as an array of strings
    NSMutableArray *tree = [NSMutableArray array];


    // add all leaves
    for (NSUInteger i = 0; i < baseNumber; i += 2) {
        NSString *line = [leafChar stringByPaddingToLength:i + 1 withString:leafChar
                                           startingAtIndex:0];
        [tree addObject:line];
    }

    // add trunk
    NSString *line = [trunkChar stringByPaddingToLength:3 withString:trunkChar
                                        startingAtIndex:0];
    [tree addObject:line];


    // print tree
    for (NSString *elem in tree) {
        CKPrint(@"%@", [elem stringByCenteringInWidth:baseNumber withCharacter:' ']);
    }

}



@end



int main(int argc, const char * argv[])
{

    @autoreleasepool {

        CKCodeKata *ck = [CKCodeKata new];

        /* one test case */
        const char *input = "3 # *";
        [ck run:[NSString stringWithUTF8String:input]];


        /* second test case */
        input =  "23 = +";
        [ck run:[NSString stringWithUTF8String:input]];

        /* second test case */
        input =  "15 ^ *";
        [ck run:[NSString stringWithUTF8String:input]];


    }

    return 0;
}
