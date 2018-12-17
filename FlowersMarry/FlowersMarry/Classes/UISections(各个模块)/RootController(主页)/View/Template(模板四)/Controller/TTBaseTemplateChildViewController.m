//
//  TTBaseTemplateChildViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/10.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTBaseTemplateChildViewController.h"

@interface TTBaseTemplateChildViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL can_scroll;
@property (nonatomic, strong) UIScrollView *scrollview;

@end

@implementation TTBaseTemplateChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(childScrollStop:) name:@"childScrollStop" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(childScrollStop:) name:@"childScrollCan" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(childScrollStop:) name:@"MainTableScroll" object:nil];
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)childScrollStop:(NSNotification *)user{
    if ([user.name isEqualToString:@"childScrollStop"]) {
        self.can_scroll = NO;
        [self.scrollview setContentOffset:CGPointZero];
    } else if ([user.name isEqualToString:@"childScrollCan"]){
        self.can_scroll = YES;
    } else if ([user.name isEqualToString:@"MainTableScroll"]){
        self.can_scroll = NO;
        [self.scrollview setContentOffset:CGPointZero];
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_can_scroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    if (scrollView.contentOffset.y<=0) {
        [kNotificationCenter postNotificationName:@"MainTableScroll" object:nil];
    }
    self.scrollview = scrollView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
