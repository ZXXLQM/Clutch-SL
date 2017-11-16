//
//  ClutchApplicationsManager.h
//  Clutch-SL
//
//  Created by 曾祥翔 on 2017/11/15.
//  Copyright © 2017年 曾祥翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClutchApplicationsManager : NSObject

@property (NS_NONATOMIC_IOSONLY,readonly,retain)NSDictionary *installedApps;

-(NSDictionary*)_allCachedApplications;
    
@end
