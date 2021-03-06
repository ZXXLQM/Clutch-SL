//
//  main.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/14.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClutchCommands.h"
#import "ClutchCommand.h"
#import "ClutchApplicationsManager.h"
#import "ClutchApplication.h"
void testPrint(void);
BOOL checkRootAndSysVersion(void);
void listApps(void);
int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (!checkRootAndSysVersion()){
            //return 0;
        }
        
        listApps();
        
        ClutchPrint *cPrint = [ClutchPrint sharedInstance];
        [cPrint setColorLevel:ClutchPrinterColorLevelFull];
        [cPrint setVerboseLevel:ClutchPrinterVerboseLevelNone];
        
        //获取进程参数（`NSProcessInfo` 还可以获取其他的进程信息。例如进程标识符，进程名，进程环境变量等）
        NSArray *arguments = [[NSProcessInfo processInfo] arguments];
        arguments = @[arguments[0],@"-d",@"1"];
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
                        //没有参数
                    case ClutchCommandOptionNone:
                    {
                        [cPrint print:@"%@",commands.helpString];
                    }
                       break;
                    case ClutchCommandOptionFrameworkDump:
                    {
                        //暂时没写
                    }
                        break;
                        //Clutch-SL -b[--binary-dump] <bundleid or num>
                    case ClutchCommandOptionDump:
                    case ClutchCommandOptionBinaryDump:
                    {
                        //dump
                        NSDictionary *_installedApps = [[ClutchApplicationsManager new] _allCachedApplications];
                        for (NSString *selection in commands.values) {
                            int key;
                            ClutchApplication *_selectedApp = nil;
                            if (!(key=selection.intValue)) {
                                [[ClutchPrint sharedInstance] printDeveloper:@"using bundle identifier"];
                                _selectedApp = _installedApps[selection];
                                if (_selectedApp == nil) {
                                    [[ClutchPrint sharedInstance] print:@"Couldn't find installed app with bundle identifier: %@",selection];
                                    return 1;
                                }
                            }else{
                                [[ClutchPrint sharedInstance] printDeveloper:@"using number"];
                                NSArray *_installedArray =_installedApps.allValues;
                                
                                //key是以1开始的
                                _selectedApp = [_installedArray objectAtIndex:key-1];
                            }
                            
                            if (_selectedApp == nil) {
                                [[ClutchPrint sharedInstance] print:@"Couldn't find installed app"];
                                return 1;
                            }
                            
                            [[ClutchPrint sharedInstance] printVerbose:@"Now dumping %@", _selectedApp.bundleIdentifier];
                            //开始解密app
                            
                            if (![_selectedApp dumpToDirectoryURL:nil onlyBinaries:NO]) {
                                
                            }
                            
                            
                        }
                    }
                        break;
                        //Clutch -i[--print-installed]
                    case ClutchCommandOptionPrintInstalled:
                    {
                        //列出手机上安装的应用
                        listApps();
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

#pragma mark - 列出已安装的应用程序
void listApps(){
    ClutchApplicationsManager *_manager = [[ClutchApplicationsManager alloc] init];
    NSArray *installedApps = [_manager installedApps].allValues;
    [[ClutchPrint sharedInstance] print:@"Installed apps:"];
    NSUInteger count=0;
    NSString *space;
    for (ClutchApplication *_app in installedApps) {
        count++;
        if (count < 10) {
            space = @"  ";
        }else if (count < 100) {
            space = @" ";
        }
        ClutchPrinterColor color;
        if (count % 2 == 0) {
            color = ClutchPrinterColorPurple;
        } else {
            color = ClutchPrinterColorPink;
        }
        //输出格式为：1:  DisplayName <com.bundleIdentifier>
        [[ClutchPrint sharedInstance] printColor:color format:@"%d: %@%@ <%@>", count, space, _app.displayName, _app.bundleIdentifier];
    }
}








