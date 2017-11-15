//
//  ClutchCommands.m
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/15.
//  Copyright © 2017年 曾祥翔. All rights reserved.
//

#import "ClutchCommands.h"
#import "ClutchCommand.h"

@implementation ClutchCommands

-(instancetype)initWithArguments:(NSArray *)arguments{
    self = [super init];
    if(self){
        self.allCommands = [self buildCommands];//初始化所有命令
        self.commands = [self parseCommandWithArguments:arguments];
        self.helpString = [self buildHelpString];
    }
    return self;
}

/*
    参数：当前参数列表（NSArray<NSString *>*）
    作用：获取参数和参数对应的值
 */
-(NSArray *)parseCommandWithArguments:(NSArray *)arguments{
    
    NSMutableArray *returnCommands = [NSMutableArray new];
    NSMutableArray *returnValues = [NSMutableArray new];
    BOOL commandFound = NO;
    for (NSString *argument in arguments) {
        if ([argument isEqualToString:arguments[0]]) {
            continue;
        }
        else if([argument isEqualToString:@"--no-color"]) {
            [returnCommands insertObject:self.allCommands[8] atIndex:0];
        } else if ([argument isEqualToString:@"--verbose"]){
            [returnCommands insertObject:self.allCommands[9] atIndex:0];
        }else if ([argument hasPrefix:@"-"]){
            for (ClutchCommand *cmd in self.allCommands) {
                if ([argument isEqualToString:cmd.shortOption] || [argument isEqualToString:cmd.longOption]) {
                    
                    //找到一个参数（除`--nocolor` 、`--verbose`）
                    if (commandFound == NO) {
                        commandFound = YES;
                        [returnCommands addObject:cmd];
                        break;
                    }else{
                        [[ClutchPrint sharedInstance] print:@"Ignoring incorrectly chained command and values: %@.", argument];
                        // ignore 2nd command in chained commands like -b foo -d bar
                    }
                }
            }
        }
        else
        {
            [returnValues addObject:argument];
        }
    }
    if (returnCommands.count < 1) {
        return @[self.allCommands[0]];
    }
    self.values = returnValues;
    return returnCommands;
}
-(NSArray *)buildCommands{
    ClutchCommand *none = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionNone shortOption:nil longOption:nil commandDescription:@"None command" flag:(ClutchCommandFlagInvisible | ClutchCommandFlagNoArguments)];
    ClutchCommand *framework = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionFrameworkDump shortOption:@"-f" longOption:@"fmwk-dump" commandDescription:@"Only dump binary files from specified bundleID" flag:(ClutchCommandFlagArgumentRequired|ClutchCommandFlagInvisible)];
     ClutchCommand *binary = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionBinaryDump shortOption:@"-b" longOption:@"--binary-dump" commandDescription:@"Only dump binary files from specified bundleID" flag:ClutchCommandFlagArgumentRequired];
    ClutchCommand *dump = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionDump shortOption:@"-d" longOption:@"--dump" commandDescription:@"Dump specified bundleID into .ipa file" flag:ClutchCommandFlagArgumentRequired];
    ClutchCommand *printInstalled = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionPrintInstalled shortOption:@"-i" longOption:@"--print-installed" commandDescription:@"Prints installed applications" flag:ClutchCommandFlagNoArguments];
    ClutchCommand *clean = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionClean shortOption:nil longOption:@"--clean" commandDescription:@"Clean /var/tmp/clutch directory" flag:ClutchCommandFlagNoArguments];
    ClutchCommand *version = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionVersion shortOption:nil longOption:@"--version" commandDescription:@"Display version and exit" flag:ClutchCommandFlagNoArguments];
    ClutchCommand *help = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionHelp shortOption:@"-?" longOption:@"--help" commandDescription:@"Displays this help and exit" flag:ClutchCommandFlagNoArguments];
    ClutchCommand *noColor = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionNoColor shortOption:@"-n" longOption:@"--no-color" commandDescription:@"Prints with colors disabled" flag:ClutchCommandFlagOptional];
    ClutchCommand *verbose = [[ClutchCommand alloc] initWithCommandOption:ClutchCommandOptionVerbose shortOption:@"-v" longOption:@"--verbose" commandDescription:@"Print verbose messages" flag:ClutchCommandFlagOptional];

    return @[none, framework, binary, dump, printInstalled, clean, version, help, noColor, verbose];
}
    
    
-(NSString *)buildHelpString{
    NSMutableString *helpString = [NSMutableString stringWithFormat:@"Usage: %@ [OPTIONS]\n",[[NSProcessInfo processInfo] processName]];
    //Usage: Clutch-SL [OPTIONS]...
    for (ClutchCommand *cmd in self.allCommands) {
        BOOL isInvisible = cmd.flag & ClutchCommandFlagInvisible;
        if (!isInvisible) {
            [helpString appendFormat:@"%-2s %-30s%@\n", cmd.shortOption.UTF8String ? cmd.shortOption.UTF8String : " ", cmd.longOption.UTF8String, cmd.commandDescription];
        }
    }
    return helpString;
}
    
@end
