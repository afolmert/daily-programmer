#import <Foundation/Foundation.h>



// Utility classes

void CKPrint(NSString *format, ...)
{
    va_list args;
    va_start(args, format);

    NSString *s = [[NSString alloc] initWithFormat:format arguments:args];
    fputs([s UTF8String], stdout);
    fputs("\n", stdout);

    va_end(args);

}


///
// Remove star characters

NSString *CKRemoveStarsChars(NSString *str) {

    NSUInteger len = [str length];
    unichar buffer[len + 1];

    NSMutableString *result = [NSMutableString new];

    [str getCharacters:buffer range:NSMakeRange(0, len)];

    for (NSUInteger i = 0; i < len; i++) {
        unichar c = buffer[i];

        if (c == '*' || (i > 0 && buffer[i - 1] == '*') || (i < len - 1 && buffer[i + 1] == '*')) {
           // ignore
        } else {
            [result appendFormat:@"%C", c];
        }

    }
    return result;
}


//
// CodeKatas class

@interface CKCodeKata : NSObject

- (void)test:(NSString *)str;

@end

@implementation CKCodeKata


- (void)test:(NSString *)str
{

    NSString *result = CKRemoveStarsChars(str);

    CKPrint(@"%@ => %@", str, result);
}

@end


// Module test



int main(int argc, const char * argv[])
{

    @autoreleasepool {
        

        CKCodeKata *kata = [CKCodeKata new];
        [kata test:@"adf*lp"];
        [kata test:@"a*o"];
        [kata test:@"*dech*"];
        [kata test:@"de**po"];
        [kata test:@"sa*n*ti"];
        [kata test:@"abc"];
    }

    return 0;
}
