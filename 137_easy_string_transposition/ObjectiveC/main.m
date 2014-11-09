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


/*
 * CKCodeKata
 *
 */

@interface CKCodeKata : NSObject

- (void)run:(NSString *)input;

@end


@implementation CKCodeKata

- (NSString *)transposeText:(NSString *)text
{
    NSMutableString *result = [NSMutableString string];

    NSArray *components = [text componentsSeparatedByString:@"\n"];
    for (NSString *component in components) {
        CKPrint(@"component: %@", component);
    }

    BOOL done = NO;
    NSUInteger index = 0;

    while (!done) {

        done = YES;
        for (NSString *component in components) {
            if (index < [component length]) {
                [result appendFormat:@"%c", [component characterAtIndex:index]];
                done = NO;
            } else {
                [result appendString:@" "];
            }
        }
        index++;
        if (!done) {
            [result appendString:@"\n"];
        }
    }

    return result;
}


- (void)run:(NSString *)input
{
    CKPrint(@"CKCodeKata START");
    CKPrint(@"Got input %@", input);

    CKPrint(@"%@", [self transposeText:input]);

    CKPrint(@"CKCodeKata STOP");
}

@end

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        const char *input = "Kernel\n"
                "Microcontroller\n"
                "Register\n"
                "Memory\n"
                "Operator\n";


        CKCodeKata *kata = [CKCodeKata new];
        [kata run:@"Hello world"];

        [kata run:[NSString stringWithUTF8String:input]];

    }

    return 0;
}
