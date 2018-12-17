//
//  FMAnnotationView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/9.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "FMAnnotationView.h"
#import "FMPointAnnotation.h"

@implementation FMAnnotationView
- (instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

+ (instancetype)annotationViewWithMap:(BMKMapView *)mapView withAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        static NSString *identifier = @"annotation";
        // 1.从缓存池中取
        FMAnnotationView *annoView = (FMAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        // 2.如果缓存池中没有, 创建一个新的
        if (annoView == nil) {
            annoView = [[FMAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        if ([annotation isKindOfClass:[FMPointAnnotation class]]) {
            annoView.annotation = (FMPointAnnotation *)annotation;
        }
        annoView.image = [UIImage imageNamed:@"annotion_icon"];
        return annoView;
    }
    return nil;
}
@end
