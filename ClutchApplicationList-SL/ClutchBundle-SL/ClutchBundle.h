//
//  ClutchBundle.h
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/16.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClutchBinary;

@interface ClutchBundle : NSBundle
{
    @public
    NSOperationQueue *_dumpQueue;
}


@property ClutchBundle *parentBundle;
@property(readonly)NSString *workingPath;
@property (readonly) NSString *zipFilename;
@property (readonly) NSString *zipPrefix;
@property (readonly) NSURL *enumURL;
@property (readonly) NSURL *bundleContainerURL;
@property (readonly) NSString* displayName;
@property (readonly) ClutchBinary *executable;

- (instancetype)initWithBundleInfo:(NSDictionary *)info;
- (void)dumpToDirectoryURL:(NSURL *)directoryURL;
- (void)prepareForDump;
@end
