#import <Foundation/Foundation.h>



@interface CKCodeKata : NSObject
- (NSString *)checkType:(NSString *)input;
@end


@implementation CKCodeKata

- (BOOL)isInt:(NSString *)text
{
    BOOL result = YES;
    NSUInteger length = [text length];
    unichar *characters = malloc(sizeof(unichar) * [text length] + 1);

    [text getCharacters:characters];

    for (unsigned int i = 0; i < length; i++) {
        unichar c = characters[i];
        if (!
                ((i == 0 && (c == '+' || c == '-')) ||
                (isdigit(c)))) {
            result = NO;
            break;
        }
    }


    free(characters);
    return result;
}

- (BOOL)isFloat:(NSString *)text
{
    BOOL result = YES;
    BOOL dotOccurred = NO;
    NSUInteger length = [text length];
    unichar *characters = malloc(sizeof(unichar) * [text length] + 1);

    [text getCharacters:characters];

    for (unsigned int i = 0; i < length; i++) {
        unichar c = characters[i];
        if (!
                ((i == 0 && (c == '+' || c == '-')) ||
                (isdigit(c)))) {

            if (c == '.') {
                if (dotOccurred) {
                    result = NO;
                    break;
                }
                dotOccurred = YES;
            } else {
                result = NO;
                break;

            }
        }
    }


    free(characters);
    return result && dotOccurred;

}

/**
 *  checks if is date in format DD-MM-YYYY
 *  20-11-2012
 */
- (BOOL)isDate:(NSString *)text
{
    BOOL result = NO;
    NSArray *components = [text componentsSeparatedByString:@"-"];
    if ([components count] == 3) {
        int day = [components[0] intValue];
        int month = [components[1] intValue];
        int year = [components[2] intValue];

        if (day >= 1 && day <= 31 && month >= 1 && month <= 12 && year >= 1 && year <= 3000) {
            result = YES;
        }
    }

    return result;

}

- (NSString *)checkType:(NSString *)input
{
    if ([self isInt:input]) {
        return @"int";
    } else if ([self isFloat:input]) {
        return @"float";
    } else if ([self isDate:input]) {
        return @"date";
    } else {
        return @"text";
    }
}


- (void)run:(NSString *)input
{
    NSLog(@"Type of '%@' is: %@", input, [self checkType:input]);

}


@end

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        CKCodeKata *ck = [CKCodeKata new];

        [ck run:@"12-12-2013"];
        [ck run:@"+1234"];
        [ck run:@"-1234.0"];
        [ck run:@"lazy fox jumped!"];

    }

    return 0;
}
