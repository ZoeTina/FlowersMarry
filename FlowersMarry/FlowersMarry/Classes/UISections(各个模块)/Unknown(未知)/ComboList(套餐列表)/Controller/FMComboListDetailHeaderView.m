//
//  FMComboListDetailHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/30.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMComboListDetailHeaderView.h"
#import "FMPictureWithTextCellPicture.h"
#import "FMTemplateThreeTableViewCell.h"
#import "FMTemplateFiveTableViewCell.h"


static NSString * const reuseIdentifierPicture = @"FMPictureWithTextCellPicture";
static NSString * const reuseIdentifierTemplateThree = @"FMTemplateThreeTableViewCell";
static NSString * const reuseIdentifierTemplateFive = @"FMTemplateFiveTableViewCell";

@interface FMComboListDetailHeaderView()<UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic, copy) FMMarriedTaskHeaderViewBlock headViewBlock;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FMComboListDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void) initView{
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(IPHONE6_W(405)));
    }];
}

- (void)setTaoxiModel:(BusinessTaoxiModel *)taoxiModel{
    _taoxiModel = taoxiModel;

    [self initView];
    [self setColumnData];
    [self.tableView reloadData];
}

/// 设置栏目数据
- (void) setColumnData{
    NSArray* titleArr = [NSArray new];
    NSArray* imagesArr = [NSArray new];
    NSArray* subtitleArr = [NSArray new];
    /// channel_id  1:婚纱 2:婚庆 3:婚宴
    NSInteger tx_channel_id = [self.taoxiModel.channel_id integerValue];
    NSInteger tx_class_id = [self.taoxiModel.class_id integerValue];
    if (tx_channel_id == 1) {
        titleArr = @[@"造型",@"拍摄",@"精修",@"相册"];
        imagesArr = @[@"live_btn_t_modelling",@"live_btn_t_amera",@"live_btn_t_picture",@"live_btn_t_bookmark"];
        BusinessMetaNavModel *model = self.taoxiModel.meta_nav;
        NSString *zx_num = [NSString stringWithFormat:@"%@套",model.zx_num];
        NSString *ps_num = [NSString stringWithFormat:@"%@张",model.ps_rupan];
        NSString *jx_num = [NSString stringWithFormat:@"%@张",model.ps_jxzs];
        NSString *xc_num = [NSString stringWithFormat:@"%@本",model.cp_xcnum];
        subtitleArr = @[zx_num,ps_num,jx_num,xc_num];
        //        subtitleArr = @[@"5套",@"80张",@"60张",@"2本"];
    }else if (tx_class_id == 7) {
        titleArr = @[@"人员",@"迎宾",@"仪式",@"其它"];
        imagesArr = @[@"live_btn_t_personnel",@"live_btn_t_welcome",@"live_btn_t_ceremony",@"live_btn_t_balloon"];
    }else if (tx_class_id == 8) {
        titleArr = @[@"服装",@"试穿",@"服务",@"配件"];
        imagesArr = @[@"live_btn_t_clothing",@"live_btn_t_try",@"live_btn_t_service",@"live_btn_t_parts"];
    }
    for (int i=0; i<titleArr.count; i++) {
        FMFiveCellModel* personModel = [[FMFiveCellModel alloc] init];
        if (tx_channel_id == 1) {
            personModel.title = [titleArr lz_safeObjectAtIndex:i];
        }
        personModel.imageText = [imagesArr lz_safeObjectAtIndex:i];
        personModel.subtitle = [subtitleArr lz_safeObjectAtIndex:i];
        [self.dataArray addObject:personModel];
    }
}


#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.row==0) {
            TTLog(@"self.taoxiModel.tx_thumb --- %@",self.taoxiModel.tx_thumb);

            FMPictureWithTextCellPicture *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierPicture forIndexPath:indexPath];
            [tools.imagesView sd_setImageWithURL:kGetImageURL(self.taoxiModel.tx_thumb) placeholderImage:kGetImage(imagePlaceholder)];
//            NSString *url = @"pic6.wed114.cn/20180531/2018053115572077512072.jpg";
//            [tools.imagesView sd_setImageWithURL:kGetImageURL(url) placeholderImage:kGetImage(imagePlaceholder)];
            return tools;
        }else if(indexPath.row==1){
            FMTemplateThreeTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplateThree forIndexPath:indexPath];
            tools.taoxiModel = self.taoxiModel;
            return tools;
        }else{
            FMTemplateFiveTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplateFive forIndexPath:indexPath];
            tools.dataArray = self.dataArray;
            return tools;
        }
    return [UITableViewCell new];
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0)return IPHONE6_W(250);
    if (indexPath.row==1)return IPHONE6_W(90);
    else if (indexPath.row==2)return IPHONE6_W(53);
    return UITableViewAutomaticDimension;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -------------- 设置Header高度 --------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1||section==4) return 0.1f;
    return (section==2||section==3) ? 44.0f : 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (section==3) ? 0.f :10.f;
}

// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView lz_viewWithColor:kTableViewInSectionColor];
}

#pragma mark -------------- 设置组头 --------------
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        return nil;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMPictureWithTextCellPicture class] forCellReuseIdentifier:reuseIdentifierPicture];
        [_tableView registerClass:[FMTemplateThreeTableViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateThree];
        [_tableView registerClass:[FMTemplateFiveTableViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateFive];
        
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        //1 禁用系统自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kViewColorNormal;
    }
    return _tableView;
}

@end
