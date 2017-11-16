//
//  ClutchApplicationsManager.h
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/15.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClutchApplicationsManager : NSObject

@property (NS_NONATOMIC_IOSONLY,readonly,retain)NSDictionary *installedApps;

-(NSDictionary*)_allCachedApplications;
    
@end
