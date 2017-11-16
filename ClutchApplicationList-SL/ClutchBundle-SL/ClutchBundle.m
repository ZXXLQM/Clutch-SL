//
//  ClutchBundle.m
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/16.
//  Copyright © 2017年 曾祥翔. All rights reserved.
//

#import "ClutchBundle.h"


@implementation ClutchBundle

-(instancetype)initWithBundleInfo:(NSDictionary *)info{
    self = [super initWithURL:info[@"BundleURL"]];
    if (self) {
        _bundleContainerURL = [[info objectForKey:@"BundleContainer"] copy];
        _displayName = [[info objectForKey:@"DisplayName"] copy];
        _dumpQueue = [NSOperationQueue new];
    }
    return self;
}

@end
