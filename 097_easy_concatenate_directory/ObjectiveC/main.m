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
 * Main program
 */
@interface CKDirectoryLister : NSObject

- (void)listFilesContentAtPath:(NSString *)path withExtension:(NSString *)ext;
@end

@implementation CKDirectoryLister

- (void)dumpFileContent:(NSString *)path
{
    NSError *error;
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (error) {
        return;
    }

    CKPrint(@"%@", str);
}


- (void)listFilesContentAtPath:(NSString *)path withExtension:(NSString *)ext
{

    CKPrint(@"Listing files in  %@... ", path);

    NSFileManager *fm = [NSFileManager defaultManager];

    NSError *error;

    NSArray *allFiles =  [fm contentsOfDirectoryAtPath:path error:&error];
    if (error) {
        NSLog(@"Error occurred %@", error);
        return;

    }


    NSMutableArray *affectedFiles = [allFiles objectsAtIndexes:
            [allFiles indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                return [fm isReadableFileAtPath:[NSString
                        stringWithFormat:@"%@/%@", path, obj]] &&
                        [obj hasSuffix:ext];
                                              }]];

    affectedFiles = [affectedFiles sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];


    for (NSString *file in affectedFiles) {
        CKPrint(@"======  %@ ===== ", file);
        [self dumpFileContent:[NSString stringWithFormat:@"%@/%@", path, file]];

    }

}


@end

void CKPrintUsage(int argc, const char *argv[])
{
    NSString *programPath = [NSString stringWithUTF8String:argv[0]];
    NSString *programName = [programPath lastPathComponent];

    CKPrint(@"Usage: %@ folder", programName);

}


NSString *CKDeterminePath(int argc, const char *argv[])
{

    NSFileManager *fm = [NSFileManager defaultManager];

    NSString *path = [fm currentDirectoryPath];
    if (argc > 1) {
        NSString *argumentPath = [NSString stringWithUTF8String:argv[1]];
        BOOL isDirectory = NO;
        if ([fm fileExistsAtPath:argumentPath isDirectory:&isDirectory]) {
            if (isDirectory) {
                path = argumentPath;
            }

        }
    }
    return path;

}



int main(int argc, const char * argv[])
{

    @autoreleasepool {


        if (argc > 1 && strcmp("-h", argv[1]) == 0) {
            CKPrintUsage(argc, argv);
            exit(EXIT_SUCCESS);

        }

        NSString *path = CKDeterminePath(argc, argv);
        CKDirectoryLister *lister = [CKDirectoryLister new];
        [lister listFilesContentAtPath:path withExtension:@"txt"];

    }

    return 0;
}
