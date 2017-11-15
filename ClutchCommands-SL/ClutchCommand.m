//
//  ClutchCommand.m
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/15.
//  Copyright © 2017年 曾祥翔. All rights reserved.
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
