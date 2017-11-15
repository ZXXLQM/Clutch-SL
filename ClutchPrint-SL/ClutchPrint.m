//
//  ClutchPrint.m
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/14.
//  Copyright © 2017年 曾祥翔. All rights reserved.
//

#import "ClutchPrint.h"


@interface ClutchPrint()
{
    ClutchPrinterColorLevel colorLevel;
    ClutchPrinterVerboseLevel verboseLevel;
}
@end



@implementation ClutchPrint


+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static ClutchPrint *shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [[ClutchPrint alloc] initWithColorLevel:ClutchPrinterColorLevelNone verboseLevel:ClutchPrinterVerboseLevelNone];
    });
    return shared;
}

//带参数的初始化方法（源码中好像并没有用到~）
-(instancetype)initWithColorLevel:(ClutchPrinterColorLevel)colorLev verboseLevel:(ClutchPrinterVerboseLevel)verboseLev{
    self = [super init];
    if (self) {
        verboseLevel = verboseLev;
        colorLevel = colorLev;
    }
    return self;
}

//输出等级设置方法
-(void)setVerboseLevel:(ClutchPrinterVerboseLevel)verboseLev{
    verboseLevel = verboseLev;
}
//输出颜色等级设置方法
-(void)setColorLevel:(ClutchPrinterColorLevel)colorLev{
    colorLevel = colorLev;
}

    
/*
 巨坑：之前把格式化字符串转成一个nsstring时，写错了初始化函数。一直报错：Segmentation fault: 11
 */
-(void)print:(NSString *)format, ...{
    //如果format不为空，则用参数列表获取参数
    if (format != nil) {
        va_list args;
        va_start(args, format);
        NSString *formatString = [[NSString alloc] initWithFormat:format arguments:args];
        NSString *printString = [NSString stringWithFormat:@"%@\n",formatString];
        printf("%s",printString.UTF8String);
        va_end(args);
    }
}


-(void)printDeveloper:(NSString *)format, ...{
#ifdef DEBUG
    if (verboseLevel == ClutchPrinterVerboseLevelDeveloper || verboseLevel == ClutchPrinterVerboseLevelFull) {
        if (format != nil) {
            //获取调用堆栈
            NSArray *stackSymbolsArr = [NSThread callStackSymbols];
            NSString *stackSymbolsString = stackSymbolsArr[1];
            
            //将上层调用的堆栈信息按照 `NSCharacterSet` 中的字符切割
            NSMutableArray *stackSymbols = [NSMutableArray arrayWithArray:[stackSymbolsString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-[]+?.,"]]];
            [stackSymbols removeObject:@""];
            
            va_list args;
            va_start(args, format);
            NSString *formatString = [[NSString alloc] initWithFormat:format arguments:args];
            NSString *printString = [NSString stringWithFormat:@"%@ | %@\n",stackSymbols[3],formatString];
            printf("%s",printString.UTF8String);
            va_end(args);
        }
    }
#endif
}

//错误输出
-(void)printError:(NSString *)format,...{
    if (format != nil) {
        va_list args;
        va_start(args, format);
        
        NSString *formatString = [[NSString alloc] initWithFormat:format arguments:args];
        NSString *printString = [NSString stringWithFormat:@"Error:%@\n",formatString];
        [self printColor:ClutchPrinterColorRed format:@"%@",printString];
    }
}

//带颜色输出
-(void)printColor:(ClutchPrinterColor)color format:(NSString *)format,...{
    if (format != nil) {
        va_list args;
        va_start(args, format);
        NSString *formatString = [[NSString alloc] initWithFormat:format    arguments:args];
        NSString *printString;
        if (colorLevel == ClutchPrinterVerboseLevelNone) {
            printString = [NSString stringWithFormat:@"%@\n",formatString];
        }else if (colorLevel == ClutchPrinterColorLevelFull){
            NSString *colorString;
            switch (color) {
                case ClutchPrinterColorPink:
                    colorString = @"\033[1;35m";
                    break;
                case ClutchPrinterColorRed:
                    colorString = @"\033[1;31m";
                    break;
                case ClutchPrinterColorPurple:
                    colorString = @"\033[0;34m";
                    break;
                default:
                    colorString = @"";
                    break;
            }
            printString = [NSString stringWithFormat:@"%@%@\033[0m\n",colorString,formatString];
        }
        
        printf("%s",printString.UTF8String);
        va_end(args);
        
    }
}

//详细输出
- (void)printVerbose:(NSString *)format, ...
{
    if (verboseLevel == ClutchPrinterVerboseLevelDeveloper || verboseLevel == ClutchPrinterVerboseLevelFull)
    {
        if (format != nil)
        {
            va_list args;
            va_start(args, format);
            NSString *formatString =[[NSString alloc] initWithFormat:format arguments:args];
            NSString *printString = [NSString stringWithFormat:@"%@\n", formatString];
            printf("%s", printString.UTF8String);
            va_end(args);
        }
    }
}






@end
