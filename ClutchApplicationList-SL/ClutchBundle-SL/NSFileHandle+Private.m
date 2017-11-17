//
//  NSFileHandle+Private.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "NSFileHandle+Private.h"

@implementation NSFileHandle (Private)

-(uint32_t)intAtOffset:(unsigned long long)offset{
    uint32_t result;
    unsigned long long oldOffset = self.offsetInFile;
    
    [self seekToFileOffset:offset];
    
    NSData *data = [self readDataOfLength:sizeof(uint32_t)];
    
    [data getBytes:&result length:sizeof(uint32_t)];
    
    [self seekToFileOffset:oldOffset];
    
    return result;
}

-(void)getBytes:(void *)result inRange:(NSRange)range{
    unsigned long long oldOffset = [self offsetInFile];
    [self seekToFileOffset:range.location];
    
    NSData *data = [self readDataOfLength:range.length];
    
    [data getBytes:result length:range.length];
    
    [self seekToFileOffset:oldOffset];
}

@end
