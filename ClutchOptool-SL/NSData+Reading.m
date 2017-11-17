//
//  NSData+Reading.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "NSData+Reading.h"

@implementation NSData (Reading)

- (uint32_t)intAtOffset:(NSUInteger)offset{
    uint32_t result;
    [self getBytes:&result range:NSMakeRange(offset, sizeof(uint32_t))];
    return result;
}


@end
