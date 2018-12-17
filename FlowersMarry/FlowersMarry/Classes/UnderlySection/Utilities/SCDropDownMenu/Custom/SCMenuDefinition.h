//
//  SCMenuDefinition.h
//  SCDropDownMenu
//
//  Created by 宁小陌 on 2018/5/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#ifndef SCMenuDefinition_h
#define SCMenuDefinition_h


#endif /* SCMenuDefinition_h */

/**下拉菜单风格*/
typedef NS_ENUM(NSUInteger, SCDropDownMenuStyle) {
    SCDropDownMenuStyleTableView,//普通tableview，一行一个，可支持二级菜单
    SCDropDownMenuStyleCollectionView,//collectionView，仅支持一级菜单
    SCDropDownMenuStyleCustom//自定义视图，需设置，仅支持一级菜单
};

//代理点击回调
@class SCDropDownMenuView;
@protocol SCDropDownMenuViewDelegate <NSObject>
- (void)menuView:(SCDropDownMenuView *)menu tfColumn:(NSInteger)column;//菜单被点击
- (void)menuView:(SCDropDownMenuView *)menu selectIndex:(SCIndexPatch *)index;//下拉菜单被点击
@end

