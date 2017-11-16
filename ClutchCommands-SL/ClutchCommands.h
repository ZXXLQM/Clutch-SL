//
//  ClutchCommands.h
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/15.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClutchCommands : NSObject

@property(nonatomic,retain)NSArray *allCommands;//所有的命令
@property(nonatomic,retain)NSArray *commands;//用户输入的命令
@property(nonatomic,copy)NSString *helpString;//用法
@property(nonatomic,retain)NSArray *values;//强制参数的命令对应的值


    
    

-(instancetype)initWithArguments:(NSArray *)arguments;
@end
