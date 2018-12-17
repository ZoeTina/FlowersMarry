//
//  FMAnnotationView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/9.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMAnnotationView : BMKAnnotationView
/** 泡泡*/
//@property (nonatomic, weak) HXDetailsView *calloutView;

//@property (nonatomic, strong)HXAnnotation *hxAnnotation;

/**
 *  创建方法
 *
 *  @param mapView 地图
 *
 *  @return 大头针
 */
+ (instancetype)annotationViewWithMap:(BMKMapView *)mapView withAnnotation:(id <BMKAnnotation>)annotation;

@end

NS_ASSUME_NONNULL_END
