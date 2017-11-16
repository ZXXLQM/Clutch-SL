//
//  ClutchPrint.h
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/14.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>

//输出详细等级
typedef NS_ENUM(NSInteger,ClutchPrinterVerboseLevel){
    ClutchPrinterVerboseLevelNone = 0,
    ClutchPrinterVerboseLevelUser = 1,
    ClutchPrinterVerboseLevelDeveloper = 2,
    ClutchPrinterVerboseLevelFull = 3
};

//输出颜色等级
typedef NS_ENUM(NSInteger, ClutchPrinterColorLevel) {
    ClutchPrinterColorLevelNone = 0,
    ClutchPrinterColorLevelFormatOnly = 1,
    ClutchPrinterColorLevelFull = 2,
};

//输出颜色枚举值
typedef NS_ENUM(NSInteger, ClutchPrinterColor)
{
    ClutchPrinterColorNone = 0,
    ClutchPrinterColorRed = 1,
    ClutchPrinterColorPurple = 2,
    ClutchPrinterColorPink = 3
};



@interface ClutchPrint : NSObject


+(instancetype)sharedInstance;

-(void)setVerboseLevel:(ClutchPrinterVerboseLevel)verboseLev;
-(void)setColorLevel:(ClutchPrinterColorLevel)colorLev;

//格式化输出
-(void)print:(NSString *)format,...;

//调试模式下的格式化输出
- (void)printDeveloper:(NSString *)format,...;

//错误输出
-(void)printError:(NSString *)format,...;

//带颜色格式化输出（参数一为颜色参数）
-(void)printColor:(ClutchPrinterColor)color format:(NSString *)format,...;

//详细输出~
- (void)printVerbose:(NSString *)format, ...;
@end
