//
//  ClutchBundle.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/16.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "ClutchBundle.h"
#import "ClutchBinary.h"

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

- (void)dumpToDirectoryURL:(NSURL *)directoryURL
{
    if (_dumpQueue.operationCount)
        [_dumpQueue cancelAllOperations];
}

-(void)prepareForDump{
    _executable = [[ClutchBinary alloc] initWithBundle:self];
    [[ClutchPrint sharedInstance] printVerbose:@"Preparing to dump %@", _executable];
    [[ClutchPrint sharedInstance] printVerbose:@"Path: %@", self.executable.binaryPath];
    
    NSDictionary *ownershipInfo = @{NSFileOwnerAccountName:@"mobile", NSFileGroupOwnerAccountName:@"mobile"};
    
    [[NSFileManager defaultManager] setAttributes:ownershipInfo ofItemAtPath:self.executable.binaryPath error:nil];
}

@end
