//
//  NSData+Reading.h
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Reading)

- (uint32_t)intAtOffset:(NSUInteger)offset;

@end
