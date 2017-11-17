//
//  ClutchBinary.h
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClutchBundle,ClutchBundleDumpOperation;

@interface ClutchBinary : NSObject

@property (readonly) ClutchBundleDumpOperation *dumpOperation;
@property (readonly) BOOL hasRestrictedSegment;
@property (readonly) NSString *workingPath;
@property (readonly) NSString *binaryPath;
@property (readonly) NSString *sinfPath;
@property (readonly) NSString *supfPath;
@property (readonly) NSString *suppPath;
@property (readonly) NSString* frameworksPath;

@property (readonly) BOOL isFAT;
@property (readonly) BOOL hasARMSlice;
@property (readonly) BOOL hasARM64Slice;
@property (readonly) BOOL hasMultipleARMSlices;
@property (readonly) BOOL hasMultipleARM64Slices;

- (instancetype)initWithBundle:(ClutchBundle *)bundle;

@end
