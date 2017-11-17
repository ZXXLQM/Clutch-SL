//
//  ClutchFinalizeDumpOperation.h
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ClutchApplication;
@interface ClutchFinalizeDumpOperation : NSOperation

@property (assign) BOOL onlyBinaries;
@property (assign) NSInteger expectedBinariesCount;

- (instancetype)initWithApplication:(ClutchApplication *)application;

@end
