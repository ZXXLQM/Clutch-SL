//
//  NSFileHandle+Private.h
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileHandle (Private)

//获取偏移位置处的四个字节(不改变文件指针原来的位置)
- (uint32_t)intAtOffset:(unsigned long long)offset;

//获取range处的sizeof(result)个字节（不改变文件指针原来的位置）
- (void)getBytes:(void *)result inRange:(NSRange)range;
@end
