//
//  main.m
//  CodeKata
//
//  Created by Adam Folmert on 06/06/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <curses.h>

@protocol Runnable
- (void)run:(NSArray *)arguments;
@end

@interface CodeKata : NSObject <Runnable>

- (void)run:(NSArray *)arguments;

- (NSString *)decodeMessage:(NSString *)message;


@end

typedef unichar (^CharDecoder)(unichar);


@implementation CodeKata

- (void)run:(NSArray *)arguments
{

    NSString *str = arguments[0];
    NSLog(@"Input message %@", str);
    NSLog(@"Output message %@", [self decodeMessage:str withDecoder:^unichar (unichar c) {
            return c - 4;
    }]);

}



- (NSString *)decodeMessage:(NSString *)message withDecoder:(CharDecoder)decoder
{
    NSMutableString *result = [NSMutableString string];

    for (NSUInteger i = 0; i < [message length]; i++) {
        [result appendString:[NSString stringWithFormat:@"%c", decoder([message characterAtIndex:i])]];
    }
    return result;
}


@end




int main(int argc, const char * argv[])
{

    @autoreleasepool {

        NSString *msg =  @"Etvmp$Jsspw%%%%"
                "[e}$xs$ks%$]sy$lezi$wspzih$xli$lmhhir$qiwweki2$Rs{$mx$mw$}syv$xyvr$xs$nsmr"
                "mr$sr$xlmw$tvero2$Hs$rsx$tswx$er}xlmrk$xlex${mpp$kmzi$e{e}$xlmw$qiwweki2$Pix"
                "tistpi$higshi$xli$qiwweki$sr$xlimv$s{r$erh$vieh$xlmw$qiwweki2$]sy$ger$tpe}$epsrk"
                "f}$RSX$tswxmrk$ls{$}sy$higshih$xlmw$qiwweki2$Mrwxieh$tswx$}syv$wspyxmsr$xs$fi$}syv"
                "jezsvmxi$Lipps${svph$tvskveq$mr$sri$perkyeki$sj$}syv$glsmgi2$"
                "Qeoi$wyvi$}syv$tvskveq$we}w$&Lipps$[svph%%%&${mxl$7$%$ex$xli$irh2$Xlmw${e}"
                "tistpi$fvs{wmrk$xli$gleppirki${mpp$xlmro${i$lezi$epp$pswx$syv$qmrhw2$Xlswi${ls$tswx$lipps"
                "{svph$wspyxmsrw${mxlsyx$xli$xlvii$%%%${mpp$lezi$rsx$higshih$xli$qiwweki$erh$ws$}sy$ger$"
                "tspmxip}$tsmrx$syx$xlimv$wspyxmsr$mw$mr$ivvsv$,"
                "xli}$evi$nywx$jspps{mrk$epsrk${mxlsyx$ors{mrk-"
                "Irns}$xlmw$jyr2$Xli$xvyxl${mpp$fi$liph$f}$xlswi${ls$ger$higshi$xli$qiwweki2$"
                ">-";


        CodeKata *kata = [[CodeKata alloc] init];
        [kata run:@[msg]];

    }

    return 0;
}
