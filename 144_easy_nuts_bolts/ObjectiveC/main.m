//
//  main.m
//  CodeKata
//
//  Created by Adam Folmert on 06/06/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <curses.h>

@interface CodeKata : NSObject
- (void)run:(NSArray *)arguments;

@end


@implementation CodeKata

- (void)run:(NSArray *)arguments
{

    NSLog(@"CodeKata START ----");

    NSString *input = arguments[0];
    NSArray *lines = [input componentsSeparatedByString:@"\n"];

    __block NSUInteger count = 0;
    NSMutableDictionary *objects = [NSMutableDictionary dictionary];

    [lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        if (idx == 0) {
            count = [obj intValue];
        } else  if (idx <= count) {
            NSArray *elems = [obj componentsSeparatedByString:@" "];

            NSString *name = elems[0];
            NSUInteger price = [elems[1] intValue];
            objects[name] = [NSNumber numberWithInt:price];
        } else {

            NSArray *elems = [obj componentsSeparatedByString:@" "];

            NSString *name = elems[0];
            NSUInteger newPrice = [elems[1] intValue];

            NSNumber *existingPrice = [objects objectForKey:name];

            if (existingPrice && [existingPrice intValue] != newPrice) {
                NSInteger difference = newPrice - [objects[name] intValue];
                NSLog(@"%@ %@%d", name, difference > 0 ? @"+" : @"", difference);
            }
        }



    }];


    NSLog(@"CodeKata STOP ----");

}


@end




int main(int argc, const char * argv[])
{

    @autoreleasepool {

        NSString *input1 =  @"4\n"
                "CarriageBolt 45\n"
                "Eyebolt 50\n"
                "Washer 120\n"
                "Rivet 10\n"
                "CarriageBolt 45\n"
                "Eyebolt 45\n"
                "Washer 140\n"
                "Rivet 10";

        NSString *input2 = @"3\n"
                "2DNail 3\n"
                "4DNail 5\n"
                "8DNail 10\n"
                "8DNail 11\n"
                "4DNail 5\n"
                "2DNail 2";



        CodeKata *kata = [[CodeKata alloc] init];
        [kata run:@[input1]];

        [kata run:@[input2]];

    }

    return 0;
}
