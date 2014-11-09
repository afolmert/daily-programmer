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
  Expression
 */


typedef NS_ENUM(NSUInteger, CKOperator)
{
    CKOpMultiplication,
    CKOpAddition,
    CKOpSubstraction,
    CKOpMax
};


/*
  CKExpression
 */

@interface CKExpression : NSObject
- (NSUInteger)evaluate;
- (NSString *)show;
- (NSString *)description;
@end


@implementation CKExpression : NSObject

- (NSUInteger)evaluate
{
    [NSException raise:@"Abstract method error" format:nil];
    return 0;
}


- (NSString *)show
{
    [NSException raise:@"Abstract method error" format:nil];
    return @"";
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@: %ld", [self show], (unsigned long)[self evaluate]];
}

@end


/*
  CKValueExpression
 */

@interface CKValueExpression : CKExpression

@property (nonatomic) NSInteger value;

+ (instancetype)expressionWithValue:(NSInteger)value;
- (instancetype)initWithValue:(NSInteger)value;
- (instancetype)init;
- (NSString *)show;
- (NSUInteger)evaluate;

@end

@implementation CKValueExpression

+ (instancetype)expressionWithValue:(NSInteger)value
{
    return [[CKValueExpression alloc] initWithValue:value];

}

- (instancetype)initWithValue:(NSInteger)value
{
    self = [super init];
    if (self) {
        self.value = value;
    }
    return self;

}

- (instancetype)init
{
    return [self initWithValue:0];
}

- (NSString *)show
{
    return [NSString stringWithFormat:@"%ld", (long)self.value];
}

- (NSUInteger)evaluate
{
    return self.value;
}

@end


/*
  CKArithmeticExpression
 */
@interface CKArithmeticExpression : CKExpression
@property (nonatomic, strong) CKExpression *leftOperand;
@property (nonatomic, strong) CKExpression *rightOperand;


+ (instancetype)expressionWithLeftOperand:(CKExpression *)leftOperand andRightOperand:(CKExpression *)rightOperand;
- (instancetype)initWithLeftOperand:(CKExpression *)leftOperand andRightOperand:(CKExpression *)rightOperand;

@end

@implementation CKArithmeticExpression

+ (instancetype)expressionWithLeftOperand:(CKExpression *)leftOperand andRightOperand:(CKExpression *)rightOperand
{
    return [[self alloc] initWithLeftOperand:leftOperand andRightOperand:rightOperand];

}

- (instancetype)initWithLeftOperand:(CKExpression *)leftOperand andRightOperand:(CKExpression *)rightOperand
{
    self = [super init];
    if (self) {
        self.leftOperand = leftOperand;
        self.rightOperand = rightOperand;

    }
    return self;
}
@end

/*
  CKAdditionExpression
 */

@interface CKAdditionExpression : CKArithmeticExpression
- (NSString *)show;
- (NSUInteger)evaluate;
@end

@implementation CKAdditionExpression

- (NSString *)show
{
    return [NSString stringWithFormat:@"(%@ + %@)", [self.leftOperand show], [self.rightOperand show]];
}

- (NSUInteger)evaluate
{
    return [self.leftOperand evaluate] + [self.rightOperand evaluate];
}
@end


/*
  CKMultiplicationExpression
 */

@interface CKMultiplicationExpression : CKArithmeticExpression
- (NSString *)show;
- (NSUInteger)evaluate;
@end

@implementation CKMultiplicationExpression

- (NSString *)show
{
    return [NSString stringWithFormat:@"(%@ * %@)", [self.leftOperand show], [self.rightOperand show]];
}

- (NSUInteger)evaluate
{
    return [self.leftOperand evaluate] * [self.rightOperand evaluate];

}
@end


/*
  CKSubtractionExpressionK
 */

@interface CKSubtractionExpression : CKArithmeticExpression
- (NSString *)show;
- (NSUInteger)evaluate;
@end

@implementation CKSubtractionExpression

- (NSUInteger)evaluate
{
    return [self.leftOperand evaluate] - [self.rightOperand evaluate];

}

- (NSString *)show
{
    return [NSString stringWithFormat:@"(%@ - %@)", [self.leftOperand show], [self.rightOperand show]];

}

@end

/*
 Application

 */

@interface CKApplication : NSObject
+ (instancetype)application;
- (void)run;

- (void)testExpressions;

- (CKValueExpression *)generateRandomValueExpression;
- (CKExpression *)generateRandomArithmeticExpressionWithLeftOperand:(CKExpression *)leftOperand
                                                    andRightOperand:(CKExpression *)rightOperand;
- (CKExpression *)generateRandomTopExpression;

@end


@implementation CKApplication

+ (instancetype)application
{
    return [[CKApplication alloc] init];
}

- (CKValueExpression *)generateRandomValueExpression
{
    return [CKValueExpression expressionWithValue:(arc4random() % 10)];
}

- (CKExpression *)generateRandomArithmeticExpressionWithLeftOperand:(CKExpression *)leftOperand
                                                    andRightOperand: (CKExpression *)rightOperand
{
    CKExpression *result = nil;
    CKOperator operator = arc4random() % CKOpMax;
    switch (operator) {
        case CKOpMultiplication:
            result = [CKMultiplicationExpression expressionWithLeftOperand:leftOperand
                                                         andRightOperand:rightOperand];
            break;
        case CKOpSubstraction:
            result = [CKSubtractionExpression expressionWithLeftOperand:leftOperand
                                                         andRightOperand:rightOperand];

            break;
        case CKOpAddition:
            result = [CKAdditionExpression expressionWithLeftOperand:leftOperand
                                                      andRightOperand:rightOperand];
            break;
        default:
            [NSException raise:@"Unexpected path" format:nil];
            break;
    }
    return result;
}

- (CKExpression *)generateRandomTopExpression
{
    CKExpression *leftExpr = [self generateRandomArithmeticExpressionWithLeftOperand:[self generateRandomValueExpression]
                                                                     andRightOperand:[self generateRandomValueExpression]];
    CKExpression *rightExpr = [self generateRandomArithmeticExpressionWithLeftOperand:[self generateRandomValueExpression]
                                                                     andRightOperand:[self generateRandomValueExpression]];

    CKExpression *topExpr = [self generateRandomArithmeticExpressionWithLeftOperand:leftExpr
                                                                    andRightOperand:rightExpr];
    return topExpr;
}




- (void)run
{
    while (true) {
        CKExpression *expr = [self generateRandomTopExpression];
        CKPrint(@"What is the result of %@?", [expr show]);
        NSString *input = CKReadLine(@"> ");

        if ([input isEqualToString:@"q"]) {
            CKPrint(@"Bye!");
            break;
        }

        NSInteger inputValue = [input intValue];

        if (inputValue == [expr evaluate]) {
            CKPrint(@"Correct!");
        } else {
            CKPrint(@"Wrong answer");
        }
    }
}


@end




int main(int argc, const char *argv[])
{

    @autoreleasepool {
        CKApplication *app = [CKApplication application];
        [app run];
    }

    return 0;
}
