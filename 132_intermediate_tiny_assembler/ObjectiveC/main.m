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


@interface NSString (Utils)
- (NSString *)stringByReversing;
@end

@implementation NSString (Utils)

- (NSString *)stringByReversing
{
    NSMutableString *result = [NSMutableString string];
    for (NSInteger i = [self length] - 1; i >= 0; i--) {
        [result appendFormat:@"%c", [self characterAtIndex:i]];
    }
    return result;

}
@end


//
//
typedef NS_ENUM(NSUInteger, CKMnemonic)
{
    MnAnd,
    MnOr,
    MnXor,
    MnNot,
    MnMov,
    MnRandom,
    MnAdd,
    MnSub,
    MnJmp,
    MnJz,
    MnJeq,
    MnJls,
    MnJgt,
    MnHalt,
    MnAPrint,
    MnDPrint,
    MnErr,
    MnMax
};

//
// CKInstruction
//

@interface CKInstruction : NSObject

+ (instancetype)instructionFromString:(NSString *)string;
- (CKMnemonic)mnemonic;
- (unsigned int)operandAtIndex:(NSUInteger)index;
- (BOOL)isLiteralAtIndex:(NSUInteger)index;
- (size_t)length;
- (NSString *)assembly;

@end

@implementation CKInstruction
{
    CKMnemonic _mnemonic;
    unsigned int *_operands;
    BOOL *_flagsLiterals;
    size_t _length;
}

+ (instancetype)instructionFromString:(NSString *)string
{
    return [[self alloc] initFromString:string];
}



- (instancetype)initFromString:(NSString *)string
{
    self = [super init];
    if (self) {
        [self parseInstruction:string toMnemonic:&_mnemonic operands:&_operands flagsLiterals:&_flagsLiterals
                        length:&_length];
    }
    return self;
}


- (instancetype)init
{
    return [self initFromString:@""];

}

- (void)dealloc
{
    if (_flagsLiterals) {
        free(_flagsLiterals);
    }
    if (_operands) {
        free(_operands);
    }
}




- (unsigned int)extractOperandIntValue:(NSString *)operand isLiteral:(BOOL*)isLiteral
{
    NSString *result = nil;
    if ([operand hasPrefix:@"["] && [operand hasSuffix:@"]"]) {
        result = [operand substringWithRange:NSMakeRange(1, [operand length] - 2)];
        *isLiteral = NO;

    } else {
        result = operand;
        *isLiteral = YES;
    }
    return (unsigned int)[result intValue];

}


- (CKMnemonic)parseMnemonic:(NSString *)string
{
    string = [string uppercaseString];

    if ([string isEqualToString:@"AND"]) {
        return MnAnd;
    } else if ([string isEqualToString:@"OR"]) {
        return MnOr;
    } else if ([string isEqualToString:@"XOR"]) {
        return MnXor;
    } else if ([string isEqualToString:@"NOT"]) {
        return MnNot;
    } else if ([string isEqualToString:@"MOV"]) {
        return MnMov;
    } else if ([string isEqualToString:@"RANDOM"]) {
        return MnRandom;
    } else if ([string isEqualToString:@"ADD"]) {
        return MnAdd;
    } else if ([string isEqualToString:@"SUB"]) {
        return MnSub;
    } else if ([string isEqualToString:@"JMP"]) {
        return MnJmp;
    } else if ([string isEqualToString:@"JZ"]) {
        return MnJz;
    } else if ([string isEqualToString:@"JEQ"]) {
        return MnJeq;
    } else if ([string isEqualToString:@"JLS"]) {
        return MnJls;
    } else if ([string isEqualToString:@"JGT"]) {
        return MnJgt;
    } else if ([string isEqualToString:@"HALT"]) {
        return MnHalt;
    } else if ([string isEqualToString:@"APRINT"]) {
        return MnAPrint;
    } else if ([string isEqualToString:@"DPRINT"]) {
        return MnDPrint;
    } else {
        return MnErr;
    }
}

- (NSString *)stringFromMnemonic:(CKMnemonic)mnemonic
{
    if (mnemonic == MnAnd) {
        return @"AND";
    } else if (mnemonic == MnOr) {
        return @"OR";
    } else if (mnemonic == MnXor) {
        return @"XOR";
    } else if (mnemonic == MnNot) {
        return @"NOT";
    } else if (mnemonic == MnMov) {
        return @"MOV";
    } else if (mnemonic == MnRandom) {
        return @"RANDOM";
    } else if (mnemonic == MnAdd) {
        return @"ADD";
    } else if (mnemonic == MnSub) {
        return @"SUB";
    } else if (mnemonic == MnJmp) {
        return @"JMP";
    } else if (mnemonic == MnJz) {
        return @"JZ";
    } else if (mnemonic == MnJeq) {
        return @"JEQ";
    } else if (mnemonic == MnJls) {
        return @"JLS";
    } else if (mnemonic == MnJgt) {
        return @"JGT";
    } else if (mnemonic == MnHalt) {
        return @"HALT";
    } else if (mnemonic == MnAPrint) {
        return @"APRINT";
    } else if (mnemonic == MnDPrint) {
        return @"DPRINT";
    } else if (mnemonic == MnErr) {
        return @"ERROR";
    } else {
        return @"UNKNOWN";
    }
}

- (void)parseInstruction:(NSString *)instruction
              toMnemonic:(CKMnemonic *)mnemonic
                operands:(unsigned int **)operands
           flagsLiterals:(BOOL **)flagsLiterals
                  length:(NSUInteger *)length
{
    NSArray *parts = [instruction componentsSeparatedByCharactersInSet:
            [NSCharacterSet  whitespaceAndNewlineCharacterSet]];
    *length = [parts count] - 1;

    if (*length > 0) {
        *operands = (unsigned int *) malloc(sizeof(unsigned int) * (*length));
        *flagsLiterals = (BOOL *) malloc(sizeof(BOOL) * (*length));
    } else {
        *operands = NULL;
        *flagsLiterals = NULL;
    }

    *mnemonic = [self parseMnemonic:parts[0]];

    for (NSUInteger i = 0; i < *length; i++) {

        BOOL isLiteral = NO;
        unsigned int intValue = [self extractOperandIntValue:parts[i + 1] isLiteral:&isLiteral];

        (*operands)[i] = intValue;
        (*flagsLiterals)[i] = isLiteral;
    }
}


- (CKMnemonic)mnemonic
{
    return _mnemonic;
}

- (unsigned int)operandAtIndex:(NSUInteger)index
{
    NSAssert(index < _length, @"Index out of range");
    return _operands[index];
}




- (BOOL)isLiteralAtIndex:(NSUInteger)index
{
    NSAssert(index < _length, @"Index out of range");
    return _flagsLiterals[index];
}


- (size_t)length
{
    return _length;
}



- (NSString *)intToHex:(NSInteger)value
{
    NSMutableString *result = [NSMutableString string];

    do {
        unsigned char rem = value % 16;
        [result appendFormat:@"%c", rem < 10 ? rem + '0' : rem % 10 + 'A'];
        value = value / 16;
    } while (value > 0);

    [result appendString:@"x0"];
    return [result stringByReversing];

}


- (NSString *)operandDescriptionAtIndex:(NSUInteger)index
{

    NSAssert(index < _length, @"Index out of range");
    if (_flagsLiterals[index]) {
        return [self intToHex:_operands[index]];
    } else {
        return [NSString stringWithFormat:@"[%@]", [self intToHex:_operands[index]]];
    }
}



- (NSString *)description
{
    NSMutableString *result = [NSMutableString string];
    [result appendString:[self stringFromMnemonic:_mnemonic]];

    for (NSUInteger i = 0; i < _length; i++) {
        [result appendString:@" "];
        [result appendString:[self operandDescriptionAtIndex:i]];
    }

    return result;
}



- (NSString *)operandsAssembly
{
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < _length; i++) {
        if (i > 0) {
            [result appendString:@" "];
        }
        [result appendString:[self operandDescriptionAtIndex:i]];

    }
    return result;

}


- (NSString *)assembly
{
    NSMutableString *result  = [NSMutableString string];
    NSString *mnemonicAssembly = nil;

    if (_mnemonic == MnAnd) {

        NSAssert(_length == 2, @"Expected 2 arguments for AND ");

        if (!_flagsLiterals[0] && !_flagsLiterals[1]) {
            result = [NSString stringWithFormat:@"0x01 %@", [self operandsAssembly]];
        } else {
            result = [NSString stringWithFormat:@"@0x00 %@", [self operandsAssembly]];

        }
    } else if (_mnemonic == MnOr) {


        NSAssert(_length == 2, @"Expected 2 arguments for OR");

        if (!_flagsLiterals[0] && !_flagsLiterals[1]) {
            result = [NSString stringWithFormat:@"0x02 %@", [self operandsAssembly]];
        } else {
            result = [NSString stringWithFormat:@"0x03 %@", [self operandsAssembly]];
        }

    } else if (_mnemonic == MnXor) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnNot) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnMov) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnRandom) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnAdd) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnSub) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnJmp) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnJz) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnJeq) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnJls) {

        NSAssert(_length == 3, @"Expected 3 arguments for JSL");

        if (!_flagsLiterals[0] && !_flagsLiterals[1] && !_flagsLiterals[2]) {
            mnemonicAssembly = @"0x18";
        } else if (!_flagsLiterals[1] && !_flagsLiterals[2]) {
            mnemonicAssembly = @"0x19";
        } else if (!_flagsLiterals[0]  && !_flagsLiterals[1]) {
            mnemonicAssembly = @"0x1a";
        } else if (!_flagsLiterals[1]) {
            mnemonicAssembly = @"0x1B";
        } else {
            mnemonicAssembly = @"ERR";
        }

        result = [NSString stringWithFormat:@"%@ %@", mnemonicAssembly, [self operandsAssembly]];

    } else if (_mnemonic == MnJgt) {
        NSAssert(_length == 3, @"Expected 3 arguments for JGT");

        if (!_flagsLiterals[0] && !_flagsLiterals[1] && !_flagsLiterals[2]) {
            mnemonicAssembly = @"0x1C";
        } else if (!_flagsLiterals[1] && !_flagsLiterals[2]) {
            mnemonicAssembly = @"0x1D";
        } else if (!_flagsLiterals[0] && !_flagsLiterals[1]) {
            mnemonicAssembly = @"0x1E";
        } else if (!_flagsLiterals[1]) {
            mnemonicAssembly = @"0x1F";
        } else {
            mnemonicAssembly = @"ERR";
        }

        result = [NSString stringWithFormat:@"%@ %@", mnemonicAssembly, [self operandsAssembly]];


    } else if (_mnemonic == MnHalt) {
        result =  @"0xFF";
    } else if (_mnemonic == MnAPrint) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnDPrint) {
        result =  @"[0x00] AND";
    } else if (_mnemonic == MnErr) {
        result =  @"[0x00] AND";
    } else {
        result = @"";
    }
    return result;
}

@end


//
// CKCodeKata
//
@interface CKCodeKata : NSObject
- (void)run:(NSString *)input;
@end

@implementation CKCodeKata



- (void)run:(NSString *)input
{

    CKPrint(@"CodeKata run START");
    CKPrint(@"Got input: %@", input);

    NSArray *lines =  [input componentsSeparatedByString:@"\n"];
    for (NSString *line in lines) {
        NSLog(@"Processing line %@", line);

        CKInstruction *instruction = [CKInstruction instructionFromString:line];
        NSLog(@"Output instruction: %@", instruction);

        CKPrint([instruction assembly]);
    }

    CKPrint(@"CodeKata run STOP");

}
@end


int main(int argc, const char * argv[])
{

    @autoreleasepool {

        // TODO get code from the command line
        const char *code =  "Mov [2] 0\n"
                "Mov [3] 0\n"
                "Jeq 6 [3] [1]\n"
                "Add [3] 1\n"
                "Add [2] [0]\n"
                "Jmp 2\n"
                "Mov [0] [2]\n"
                "Halt";

        CKCodeKata *kata = [CKCodeKata new];
        [kata run:[NSString stringWithUTF8String:code]];

    }

    return 0;
}
