//
//  MVSingleChooseTableView.h
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/3/2.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseBlock) (NSString *chooseContent,NSString *muiscID);

@interface MVSingleChooseTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView      *tableView;
@property(nonatomic, strong) NSMutableArray   *dataArr;
@property(nonatomic, strong) NSIndexPath      *currentSelectIndex;
@property(nonatomic, copy) ChooseBlock block;
@property(nonatomic, strong) NSString * chooseContent;
+(MVSingleChooseTableView *) initTableWithFrame:(CGRect)frame;
-(void)reloadData;

@end
