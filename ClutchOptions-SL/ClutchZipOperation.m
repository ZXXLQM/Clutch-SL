//
//  ClutchZipOperation.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "ClutchZipOperation.h"
#import "ClutchBundle.h"
@interface ClutchZipOperation ()
{
    ClutchBundle *_application;
    BOOL _executing, _finished;
    //ZipArchive *_archive;
}
@end

@implementation ClutchZipOperation

- (id)initWithApplication:(ClutchBundle *)application {
    self = [super init];
    if (self) {
        _executing = NO;
        _finished = NO;
        _application = application;
    }
    return self;
}

@end
