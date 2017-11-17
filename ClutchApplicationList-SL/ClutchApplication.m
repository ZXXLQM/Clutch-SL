//
//  ClutchApplication.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/16.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "ClutchApplication.h"
#import "ClutchBundle.h"
#import "ClutchZipOperation.h"
#import "ClutchBundleDumpOperation.h"
#import "ClutchBinary.h"
#import "ClutchFinalizeDumpOperation.h"
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

- (BOOL)dumpToDirectoryURL:(NSURL *)directoryURL onlyBinaries:(BOOL)_onlyBinaries{
    [super dumpToDirectoryURL:directoryURL];
    [self prepareForDump];
    [[NSFileManager defaultManager]createDirectoryAtPath:_workingPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    ClutchZipOperation *_mainZipOperation = [[ClutchZipOperation alloc] initWithApplication:self];
    
    ClutchBundleDumpOperation *_dumpOperation = self.executable.dumpOperation;
    
    ClutchFinalizeDumpOperation *_finalizeDumpOperation = [[ClutchFinalizeDumpOperation alloc]initWithApplication:self];
    _finalizeDumpOperation.onlyBinaries = _onlyBinaries;

    if (!_onlyBinaries) {
        [_finalizeDumpOperation addDependency:_mainZipOperation];
    }
    [_finalizeDumpOperation addDependency:_dumpOperation];
    
    NSMutableArray *_additionalDumpOpeartions = ({
        NSMutableArray *array = [NSMutableArray new];
//        for (Framework *_framework in self.frameworks) {
//            [array addObject:_framework.executable.dumpOperation];
//        }
//        for (Extension *_extension in self.extensions) {
//            [array addObject:_extension.executable.dumpOperation];
//        }
        array;
    });
    BOOL fail = NO;
    return fail;
}

- (void)prepareForDump {
    
    [super prepareForDump];
    
    for (ClutchBundle *bundle in _frameworks)
        [bundle prepareForDump];
    
    for (ClutchBundle *bundle in _extensions)
        [bundle prepareForDump];
}

@end
