#import <Foundation/Foundation.h>


void CKPrint(NSString *format, ...)
{
    va_list args;
    va_start(args, format);

    NSString *s = [[NSString alloc] initWithFormat:format arguments:args];
    fputs([s UTF8String], stdout);
    fputs("\n", stdout);

    va_end(args);

}


@interface CKApplication : NSObject
- (void)run:(NSString *)filePath;
@end


@implementation CKApplication

- (NSString *)toHexString:(unsigned char *)bytes ofLength:(NSUInteger)length
{
    NSMutableString *result = [NSMutableString string];

    for (int i = 0; i < length; i++) {
        unsigned char byte = bytes[i];

        unsigned char lo = byte / 16;
        unsigned char hi = byte % 16;

        if (i > 0) {
            [result appendString:@" "];
        }
        [result appendFormat:@"%c", lo < 10 ? '0' + lo : 'A' + lo % 10];
        [result appendFormat:@"%c", hi < 10 ? '0' + hi : 'A' + hi % 10];
    }

    return result;

}

- (void)run:(NSString *)filePath
{
    NSFileManager *fm = [NSFileManager defaultManager];

    if (![fm fileExistsAtPath:filePath] && [fm isReadableFileAtPath:filePath]) {
        NSLog(@"File does not exist %@", filePath);
        exit(1);
    }

    NSData *data = [NSData dataWithContentsOfFile:filePath];

    if (!data) {
        NSLog(@"Cannot read file %@", filePath);
        exit(1);
    }


    NSUInteger length = [data length];
    const char *bytes = (const char *)[data bytes];

    for (NSUInteger i = 0; i < length; i++) {
        unsigned char byte = bytes[i];

//        printf("%s", [@"A" stringByPaddingToLength:16 withString:@"0"
//                                   startingAtIndex:0]);
        NSLog(@"Read one byte %c", byte);
    }

    CKPrint(@"%@", [self toHexString:bytes ofLength:length]);
}


@end

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        if (argc > 0) {
            for (int i = 0; i < argc; i++) {
                NSLog(@"Argument %d is %s", i, argv[i]);
            }
        }

        CKApplication *app = [[CKApplication alloc] init];
        [app run:@"/tmp/ala"];

    }

    return 0;
}
