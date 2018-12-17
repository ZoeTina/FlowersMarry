//
//  TTWGS84TOGCJ02.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/27.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TTWGS84TOGCJ02 : NSObject
//判断是否已经超出中国范围
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
//转GCJ-02
+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;
@end

NS_ASSUME_NONNULL_END
