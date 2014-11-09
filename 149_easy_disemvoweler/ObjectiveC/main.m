

@interface CodeKata : NSObject
- (void)run:(NSArray *)arguments;

@end


@implementation CodeKata

- (void)splitText:(NSString *)text toConsonants:(NSString **)consonants andVowels:(NSString **)vowels
{
    NSCharacterSet *vowelsSet = [NSCharacterSet characterSetWithCharactersInString:@"aoeiou"];

    NSMutableString *mutableVowels = [NSMutableString string];
    NSMutableString *mutableConsonants = [NSMutableString string];

    // get all characters
    unsigned int len = [text length];
    unichar buffer[len + 1];

    [text getCharacters:buffer range:NSMakeRange(0, len)];



    for (NSUInteger i = 0; i < len; i++) {

        unichar c = buffer[i];
        if (c == ' ') {
            // ignore
        } else  if ([vowelsSet characterIsMember:c]) {
            [mutableVowels appendString:[NSString stringWithCharacters:&c length:1]];
        }  else {
            [mutableConsonants appendString:[NSString stringWithCharacters:&c length:1]];
        }

    }

    *consonants = mutableConsonants;
    *vowels = mutableVowels;

}


- (void)run:(NSArray *)arguments
{

    for (NSString *argument in arguments) {
        NSString *vowels = nil;
        NSString *consonants = nil;
        [self splitText:argument toConsonants:&consonants andVowels:&vowels];
        NSLog(@"%@\n%@", consonants, vowels);
    }
}


@end




int main(int argc, const char * argv[])
{

    @autoreleasepool {

        NSArray *arguments = @[@"all those who believe in psychokinesis raise my hand",
                @"did you hear about the excellent farmer who was outstanding in his field"];

        CodeKata *kata = [[CodeKata alloc] init];
        [kata run:arguments];

    }

    return 0;
}
