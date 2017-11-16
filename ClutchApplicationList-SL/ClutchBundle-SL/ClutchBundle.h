//
//  ClutchBundle.h
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/16.
//  Copyright © 2017年 曾祥翔. All rights reserved.
//

#import <Foundation/Foundation.h>

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
- (instancetype)initWithBundleInfo:(NSDictionary *)info;
@end
