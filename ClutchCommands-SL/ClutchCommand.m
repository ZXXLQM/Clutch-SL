//
//  ClutchCommand.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/15.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "ClutchCommand.h"

@implementation ClutchCommand

- (instancetype)initWithCommandOption:(ClutchCommandOption)commandOption shortOption:(NSString *)shortOption longOption:(NSString *)longOption commandDescription:(NSString *)commandDescription flag:(ClutchCommandFlag)flag{
    self = [super init];
    if(self){
        self.option = commandOption;
        self.shortOption = shortOption;
        self.longOption = longOption;
        self.commandDescription = commandDescription;
        self.flag = flag;
    }
    return self;
}
    
@end
