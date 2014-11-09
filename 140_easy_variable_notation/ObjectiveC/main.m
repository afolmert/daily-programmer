#import <Foundation/Foundation.h>

@interface CodeKata : NSObject
- (void)run:(NSArray *)arguments;

@end

typedef NSString *(^Transformer)(NSString *);


typedef NS_ENUM(NSUInteger, CKNotation) {
    CKNotationCamelCase,
    CKNotationSnakeCase,
    CKNotationCapitalizedSnakeCase,
    CKNotationMax
};


@implementation CodeKata


- (void)initializeTransformations:(NSMutableArray *)array
{
    [array removeAllObjects];
    for (NSUInteger i = 0; i < CKNotationMax; i++) {
        [array addObject:[NSNull null]];
    }

    array[CKNotationCamelCase] = ^NSString *(NSString *input) {

        NSArray *words = [input componentsSeparatedByString:@" "];
        NSMutableString *result = [NSMutableString string];

        for (NSString *word in words) {
            [result appendString:[[word substringToIndex:1] uppercaseString]];
            [result appendString:[word substringFromIndex:1]];
        }
        return result;
    };
    array[CKNotationSnakeCase] = ^NSString *(NSString *input) {

        NSArray *words = [input componentsSeparatedByString:@" "];
        NSMutableString *result = [NSMutableString string];

        NSUInteger i = 0;
        for (NSString *word in words) {
            if (i > 0) {
                [result appendString:@"_"];
            }
            [result appendString:word];
            i++;

        }
        return result;
    };
    array[CKNotationCapitalizedSnakeCase] = ^NSString *(NSString *input) {

        NSArray *words = [input componentsSeparatedByString:@" "];
        NSMutableString *result = [NSMutableString string];

        NSUInteger i = 0;
        for (NSString *word in words) {
            if (i > 0) {
                [result appendString:@"_"];
            }
            [result appendString:[[word substringToIndex:1] uppercaseString]];
            [result appendString:[word substringFromIndex:1]];
            i++;

        }

        return result;
    };

}

- (void)run:(NSArray *)arguments
{
    NSString *input = arguments[0];

    NSLog(@"Got input : %@", input);

    NSArray *elems = [input componentsSeparatedByString:@"\n"];

    NSString *name = @"";
    CKNotation currentNotation = CKNotationCamelCase;

    NSMutableArray *transformations = [NSMutableArray array];
    [self initializeTransformations:transformations];

    for (NSUInteger i = 0; i < [elems count]; i++) {

        if (i % 2 == 0) {
            currentNotation = [elems[i] intValue];
            NSLog(@"%@", elems[i]);
        } else {
            Transformer transformer = transformations[currentNotation];
            NSString *output = transformer(elems[i]);
            NSLog(@"%@", output);
        }
    }
}


@end




int main(int argc, const char * argv[])
{

    @autoreleasepool {

        NSString *input = @"0\n"
                "hello world\n"
                "1\n"
                "user id\n"
                "2\n"
                "map controller delegate manager\n"
                "1\n"
                "brown fox jumps";


        CodeKata *kata = [[CodeKata alloc] init];
        [kata run:@[input]];

    }

    return 0;
}
