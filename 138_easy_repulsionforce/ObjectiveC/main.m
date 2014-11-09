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

/**
 *  Particle
*/

@interface CKParticle : NSObject

+ (instancetype)particleFromString:(NSString *)input;
- (instancetype)initFromString:(NSString *)input;
- (instancetype)init;
- (double)repulsionForceToParticle:(CKParticle *)particle;

@property (nonatomic) double mass;
@property (nonatomic) double xPosition;
@property (nonatomic) double yPosition;

- (double)repulsionForce;


@end

@implementation CKParticle

+ (instancetype)particleFromString:(NSString *)input
{
    return [[self alloc] initFromString:input];
}


- (instancetype)initFromString:(NSString *)input
{
    self = [super init];
    if (self) {
        NSArray *components = [input componentsSeparatedByString:@" "];

        if ([components count] != 3) {
            [NSException raise:@"Error" format:@"Expecting 3 components, got %d in '%@", [components count], input];
        }

        _mass = [components[0] doubleValue];
        _xPosition = [components[1] doubleValue];
        _yPosition = [components[2] doubleValue];
    }
    return self;

}

- (instancetype)init
{
    return [self initFromString:@"0 0 0"];
}


- (double)repulsionForceToParticle:(CKParticle *)particle
{
    double deltaX = _xPosition - [particle xPosition];
    double deltaY = _yPosition - [particle yPosition];
    double distance =  sqrt(deltaX * deltaX + deltaY * deltaY);

    NSLog(@"Distance is %f", distance);

    double force = (_mass * [particle mass]) / (distance * distance);
    return force;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"Mass: %f xPostion: %f yPosition: %f", _mass, _xPosition, _yPosition];
}
@end
/**
* Main class
*/

@interface CKCodeKata : NSObject
- (void)run:(NSString *)input;
@end

@implementation CKCodeKata

- (void)run:(NSString *)input
{
    NSArray *particles = [input componentsSeparatedByString:@"\n"];

    CKParticle *particle1 = [CKParticle particleFromString:particles[0]];
    CKParticle *particle2 = [CKParticle particleFromString:particles[1]];

    CKPrint(@"Particle1 : %@", particle1);
    CKPrint(@"Particle2 : %@", particle2);

    CKPrint(@"Repulsion force : %f", [particle1 repulsionForceToParticle:particle2]);
    CKPrint(@"Repulsion force : %f", [particle2 repulsionForceToParticle:particle1]);

}


@end




int main(int argc, const char * argv[])
{

    @autoreleasepool {

        CKCodeKata *ck = [CKCodeKata new];


        const char *input1 = "1 -5.2 3.8\n"
                "1 8.7 -4.1";
        // expecting :   0.0039

        [ck run:[NSString stringWithUTF8String:input1]];



        const char *input2 =  "4 0.04 -0.02\n"
                "4 -0.02 -0.03";
        // expecting: 4324.3279


        [ck run:[NSString stringWithUTF8String:input2]];


        const char *input3 = "10 0.2 -0.2\n"
        "10 10 0.3";

        NSString *arguments = [NSString stringWithUTF8String:input3];
        [ck run:arguments];

    }

    return 0;
}
