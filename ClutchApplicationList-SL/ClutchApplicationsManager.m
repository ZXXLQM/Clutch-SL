//
//  ClutchApplicationsManager.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/15.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "ClutchApplicationsManager.h"
#import <dlfcn.h>
#import "LSApplicationWorkspace.h"
#import "LSApplicationProxy.h"
#import "ClutchApplication.h"
#define applistCachePath [NSString stringWithFormat:@"%@/applist-cache.plist",DEFAULTPATH]

typedef NSDictionary* (*MobileInstallationLookup)(NSDictionary *options);

@interface ClutchApplicationsManager ()
{
    NSMutableArray *_cacheApps;
}
@end

@implementation ClutchApplicationsManager

-(instancetype)init{
    self = [super init];
    if (self) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:applistCachePath]) {
            _cacheApps = [[NSMutableArray alloc] initWithContentsOfFile:applistCachePath];
        }else{
            _cacheApps = [NSMutableArray new];
        }
    }
    return self;
}


#pragma mark - iOS7以下获取手机上安装的应用程序
- (NSDictionary *)listApplicationsForiOS7AndLower {
    MobileInstallationLookup mobileInstallationLookup;
    void * MIHandle;
    NSMutableDictionary *returnValue = [NSMutableDictionary new];
    MIHandle = dlopen("/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation", RTLD_NOW);
    mobileInstallationLookup = NULL;
    
    if (MIHandle)
    {
        mobileInstallationLookup = dlsym(MIHandle,"MobileInstallationLookup");
        if (mobileInstallationLookup)
        {
            
            NSDictionary *installedApps;
            NSDictionary* options = @{@"ApplicationType":@"User",
                                      @"ReturnAttributes":@[@"CFBundleShortVersionString",
                                                            @"CFBundleVersion",
                                                            @"Path",
                                                            @"CFBundleDisplayName",
                                                            @"CFBundleExecutable",
                                                            @"MinimumOSVersion"]};
            
            installedApps = mobileInstallationLookup(options);
            
            
            for (NSString *bundleID in installedApps.allKeys)
            {
                NSDictionary *appI = installedApps[bundleID];
                NSURL *bundleURL = [NSURL fileURLWithPath:appI[@"Path"]];
                NSString *scinfo = [bundleURL.path stringByAppendingPathComponent:@"SC_Info"];
                
                BOOL isDirectory;
                BOOL purchased = [[NSFileManager defaultManager]fileExistsAtPath:scinfo isDirectory:&isDirectory];
                
                if (purchased && isDirectory)
                {
                    NSString *name = appI[@"CFBundleDisplayName"];
                    if (name == nil)
                    {
                        name = appI[@"CFBundleExecutable"];
                    }
                    
                    NSDictionary *bundleInfo = @{@"BundleContainer":bundleURL.URLByDeletingLastPathComponent,
                                                 @"BundleURL":bundleURL,
                                                 @"DisplayName": name,
                                                 @"BundleIdentifier": bundleID};
                    ClutchApplication *app = [[ClutchApplication alloc] initWithBundleInfo:bundleInfo];
                    returnValue[bundleID] = app;
                    
                    [self cacheBundle:bundleInfo];
                }
            }
        }
    }
    [self writeToCache];
    return returnValue;
}

#pragma mark - ios8.0以上版本获取已安装的软件
-(NSDictionary *)listApplicationsForiOS8AndHigher{
    NSMutableDictionary *returnValue = [NSMutableDictionary new];
    LSApplicationWorkspace *applicationWorkspace = [LSApplicationWorkspace defaultWorkspace];
    NSArray *proxies = [applicationWorkspace allApplications];
    NSDictionary *bundleInfo = nil;
    for (LSApplicationProxy *proxy in proxies) {
        NSString *appType = [proxy performSelector:@selector(applicationType)];
        
        if ([appType isEqualToString:@"User"] && proxy.bundleContainerURL && proxy.bundleURL) {
            NSString *scinfo = [proxy.bundleURL.path stringByAppendingPathComponent:@"SC_Info"];
            BOOL isDirectory;
            BOOL purchased = [[NSFileManager defaultManager] fileExistsAtPath:scinfo isDirectory:&isDirectory];
            if (purchased && isDirectory){
                NSString *itemName = proxy.itemName;
                if (!itemName) {
                    itemName = proxy.localizedName;
                }
                bundleInfo = @{@"BundleContainer":proxy.bundleContainerURL,
                               @"BundleURL":proxy.bundleURL,
                               @"DisplayName": itemName,
                               @"BundleIdentifier": proxy.bundleIdentifier
                               };
                ClutchApplication *app = [[ClutchApplication alloc] initWithBundleInfo:bundleInfo];
                returnValue[proxy.bundleIdentifier] = app;
                [self cacheBundle:bundleInfo];
            }
        }
    }
    [self writeToCache];
    return returnValue;
}

-(void)cacheBundle:(NSDictionary*) bundle
{
    [_cacheApps addObject:bundle];
}

- (void)writeToCache
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        [_cacheApps writeToFile:applistCachePath atomically:YES];
    });
}

-(NSDictionary *)_allCachedApplications{
    return nil;
}


//重写get方法，获取应用列表
- (NSDictionary *)installedApps
{
    return [self _allApplications];
}
- (NSDictionary *)_allApplications{
    NSDictionary *returnValue;
    if (SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(NSFoundationVersionNumber_iOS_7_0))
    {
        //returnValue = [self listApplicationsForiOS7AndLower];
    }
    else
    {
        returnValue = [self listApplicationsForiOS8AndHigher];
    }
    
    return returnValue.copy;
}

@end
