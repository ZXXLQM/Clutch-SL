//
//  main.m
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/14.
//  Copyright © 2017年 曾祥翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClutchCommands.h"
#import "ClutchCommand.h"
void testPrint(void);
BOOL checkRootAndSysVersion(void);
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        if (!checkRootAndSysVersion()){
            return 0;
        }
        ClutchPrint *cPrint = [ClutchPrint sharedInstance];
        [cPrint setColorLevel:ClutchPrinterColorLevelFull];
        [cPrint setVerboseLevel:ClutchPrinterVerboseLevelNone];
        
        //获取进程参数（`NSProcessInfo` 还可以获取其他的进程信息。例如进程标识符，进程名，进程环境变量等）
        NSArray *arguments = [[NSProcessInfo processInfo] arguments];
        
        ClutchCommands *commands = [[ClutchCommands alloc] initWithArguments:arguments];
        
        if (commands.commands) {
            for (ClutchCommand *command in commands.commands) {
                switch (command.option) {
                    case ClutchCommandOptionNoColor:
                    {
                        [cPrint setColorLevel:ClutchPrinterColorLevelNone];
                    }
                        break;
                    case ClutchCommandOptionVerbose:
                    {
                        [cPrint setVerboseLevel:ClutchPrinterVerboseLevelFull];
                    }
                        break;
                    default:
                    break;
                }
                switch (command.option) {
                    case ClutchCommandOptionNone:
                    {
                        [cPrint print:@"%@",commands.helpString];
                    }
                       break;
                    case ClutchCommandOptionFrameworkDump:
                    {
                        //暂时不写
                    }
                        break;
                    case ClutchCommandOptionDump:
                    case ClutchCommandOptionBinaryDump:
                    {
                        //暂时不写
                    }
                        break;
                    case ClutchCommandOptionPrintInstalled:
                    {
                        //列出手机上安装的应用
                    }
                        break;
                    case ClutchCommandOptionClean:
                    {
                        //清除默认目录下的文件
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        [fileManager removeItemAtPath:DEFAULTPATH error:nil];
                        [fileManager createDirectoryAtPath:DEFAULTPATH withIntermediateDirectories:YES attributes:nil error:nil];
                    }
                        break;
                    case ClutchCommandOptionVersion:
                    {
                        //输出版本~
                    }
                        break;
                    case ClutchCommandOptionHelp:
                    {
                        //输出使用说明
                        [[ClutchPrint sharedInstance] print:@"%@", commands.helpString];
                    }
                        break;
                    default:
                    break;
                }
            }
        }
        
        
        [cPrint printColor:ClutchPrinterColorPink format:@"%@",arguments];
        
        return 0;
    }
}
#pragma mark - 判断运行权限和系统版本
BOOL checkRootAndSysVersion(void){
    //判断是否是以root权限运行
    if(getuid() != 0) {
        [[ClutchPrint sharedInstance] print:@"Clutch-SL needs to be run as the root user, please change user and rerun."];
        return NO;
    }
    //判断系统是否低于iOS8.0
    if(SYSTEM_VERSION_LESS_THAN(NSFoundationVersionNumber_iOS_8_0)){
        [[ClutchPrint sharedInstance] print:@"You need iOS 8.0+ to use Clutch-SL."];
        return NO;
    }
    return YES;
}

#pragma mark - 输出测试
void testPrint(void){
    printf("简单测试\n");
    //简单输出
    [[ClutchPrint sharedInstance] print:@"%@",@"我只是一个简单的输出"];
    //带颜色输出
    [[ClutchPrint sharedInstance] setColorLevel:ClutchPrinterColorLevelFull];
    [[ClutchPrint sharedInstance] printColor:ClutchPrinterColorPurple format:@"%@",@"我的文字是紫色的"];
    //错误输出
    [[ClutchPrint sharedInstance] printError:@"%@",@"我是一个错误"];
}
