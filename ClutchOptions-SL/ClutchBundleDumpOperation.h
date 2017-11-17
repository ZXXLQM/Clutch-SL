//
//  ClutchBundleDumpOperation.h
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ClutchBundle;

@interface ClutchBundleDumpOperation : NSOperation

- (instancetype)initWithBundle:(ClutchBundle *)application;

@end
