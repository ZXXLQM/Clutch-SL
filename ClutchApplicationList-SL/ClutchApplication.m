//
//  ClutchApplication.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/16.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "ClutchApplication.h"

@interface ClutchApplication ()
{
    NSUUID *_workingUUID;
    NSMutableArray *_frameworks;
    NSMutableArray *_extensions;
    NSMutableArray *_watchOSApps;
    NSString *_workingPath;
}
@end


@implementation ClutchApplication

-(instancetype)initWithBundleInfo:(NSDictionary *)info{
    self = [super initWithBundleInfo:info];
    if (self) {
        _workingUUID = [NSUUID new];
        _workingPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[@"clutch" stringByAppendingPathComponent:_workingUUID.UUIDString]];
        
    }
    return self;
}


@end
