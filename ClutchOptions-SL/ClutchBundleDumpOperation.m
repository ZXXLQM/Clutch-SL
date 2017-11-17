//
//  ClutchBundleDumpOperation.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "ClutchBundleDumpOperation.h"
#import "ClutchBundle.h"

@import ObjectiveC.runtime;

@interface ClutchBundleDumpOperation ()
{
    ClutchBundle *_application;
    BOOL _executing, _finished, failed;
    NSString *_binaryDumpPath;
}

//+ (NSArray *)availableDumpers;

@end
@implementation ClutchBundleDumpOperation
- (instancetype)initWithBundle:(ClutchBundle *)application{
    self = [super init];
    if (self) {
        _executing = NO;
        _finished = NO;
        _application = application;
    }
    return self;
}
@end
