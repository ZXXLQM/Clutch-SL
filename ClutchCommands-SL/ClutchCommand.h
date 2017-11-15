//
//  ClutchCommand.h
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/15.
//  Copyright © 2017年 曾祥翔. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef NS_OPTIONS(NSInteger, ClutchCommandFlag){
    ClutchCommandFlagNone = 0,
    ClutchCommandFlagInvisible = 1 << 0, // don't print to help
    ClutchCommandFlagArgumentRequired = 1 << 1, // requires args
    ClutchCommandFlagNoArguments = 1 << 2, // will not take args
    ClutchCommandFlagOptional = 1 << 3, // can be optionally added to any other command (i.e. --verbose)
};
typedef NS_ENUM(NSUInteger, ClutchCommandOption) {
    ClutchCommandOptionNone,
    ClutchCommandOptionFrameworkDump,
    ClutchCommandOptionBinaryDump,
    ClutchCommandOptionDump,
    ClutchCommandOptionPrintInstalled,
    ClutchCommandOptionClean,
    ClutchCommandOptionVersion,
    ClutchCommandOptionHelp,
    ClutchCommandOptionNoColor,
    ClutchCommandOptionVerbose
};

@interface ClutchCommand : NSObject
@property(nonatomic,copy) NSString *shortOption;
@property(nonatomic,copy) NSString *longOption;
@property(nonatomic,copy)NSString *commandDescription;
@property(nonatomic,assign)ClutchCommandFlag flag;
@property(nonatomic,assign)ClutchCommandOption option;
    
- (instancetype)initWithCommandOption:(ClutchCommandOption)commandOption shortOption:(NSString *)shortOption longOption:(NSString *)longOption commandDescription:(NSString *)commandDescription flag:(ClutchCommandFlag)flag;
    
@end
