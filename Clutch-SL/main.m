//
//  main.m
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/14.
//  Copyright © 2017年 曾祥翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClutchPrint.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //测试格式化输出代码
        printf("简单测试\n");
        //简单输出
        [[ClutchPrint sharedInstance] print:@"%@",@"我只是一个简单的输出"];
        
        //带颜色输出
        [[ClutchPrint sharedInstance] setColorLevel:ClutchPrinterColorLevelFull];
        [[ClutchPrint sharedInstance] printColor:ClutchPrinterColorPurple format:@"%@",@"我的文字是紫色的"];
        //错误输出
        [[ClutchPrint sharedInstance] printError:@"%@",@"我是一个错误"];
        return 0;
    }
}
