//
//  ClutchApplication.h
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/16.
//  Copyright © 2017年 曾祥翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClutchBundle-SL/ClutchBundle.h"
@interface ClutchApplication :ClutchBundle

@property (readonly) BOOL hasAppleWatchApp; // YES if contains watchOS 2 compatible application
@property (readonly) BOOL isAppleWatchApp; // only for Apple Watch apps that support watchOS 2 or newer (armv7k)

@property (readonly) NSArray *extensions;
@property (readonly) NSArray *frameworks;
@property (readonly) NSArray *watchOSApps;

@end
