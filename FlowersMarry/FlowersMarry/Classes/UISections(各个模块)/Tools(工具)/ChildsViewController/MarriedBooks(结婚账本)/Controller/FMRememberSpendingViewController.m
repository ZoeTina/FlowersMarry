//
//  FMRememberSpendingViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMRememberSpendingViewController.h"

#import "TZImagePickerController.h"
#import "SCPublishPictureCell.h"
#import "FMRememberSpendingView.h"

static NSString * const reuseIdentifier = @"SCPublishPictureCell";

@interface FMRememberSpendingViewController ()<SCSegmentTitleViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,
TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) SCSegmentTitleView *titleView;
@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *nicknameTextField;
@property (nonatomic, strong) UIImageView *imagesAvatar;
@property (nonatomic, strong) UITextField *amountTextField;

@property (nonatomic, strong) UIImageView *imagesIcon1;
@property (nonatomic, strong) UIImageView *imagesIcon2;
@property (nonatomic, strong) UIImageView *imagesIcon3;
@property (nonatomic, strong) UILabel *dataLabel;
@property (nonatomic, strong) UITextField *remarkTextField;

/// 删除
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray *imagesPhotosArray;
/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;
@property(nonatomic, strong) NSMutableArray *selectedAssets;


@property(nonatomic, strong) UIView *view1;
@property(nonatomic, strong) UIView *view2;
@property(nonatomic, strong) UIView *view3;
@property(nonatomic, strong) UIView *view4;
@property(nonatomic, strong) FMRememberSpendingView *view5;
@end

@implementation FMRememberSpendingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"记开支";
    [self initView];
    [self initViewConstraints];
    self.titleView.selectIndex = 2;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick)];
    singleTap.numberOfTapsRequired = 1;
    self.scrollView.userInteractionEnabled = YES;
    [self.scrollView  addGestureRecognizer:singleTap];
    
    // 注册通知
    [kNotificationCenter addObserver:self selector:@selector(openPhotoAlbum) name:@"openPhotoAlbum" object:nil];
    if (self.idxType==1) {
        self.titleView.selectIndex = 1;
    }else{
        self.titleView.selectIndex = 3;
    }
    
    [self.imagesAvatar sd_setImageWithURL:kGetImageURL(@"") placeholderImage:kGetImage(mineAvatar)];
    
    self.dataLabel.text = @"2018-10-05";
}

- (void) scrollViewClick{
    
}

- (void) openPhotoAlbum{
//    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = kWhiteColor;
    self.navigationController.navigationBar.translucent = YES;// NavigationBar 是否透明
}

- (void) initView{
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(49));
    }];
    
    CGRect view1Frame = CGRectMake(0, kNavBarHeight+44, kScreenWidth, 70);
    self.view1 = [self viewWithFrame:view1Frame left:0];

    self.view5 = [[FMRememberSpendingView alloc] init];
    self.view5.frame = CGRectMake(0, CGRectGetMaxY(self.view1.frame), kScreenWidth, 112);
    
    CGRect view2Frame = CGRectMake(0, CGRectGetMaxY(self.view5.frame)+26, kScreenWidth, 55);
    self.view2 = [self viewWithFrame:view2Frame left:15];

    CGRect view3Frame = CGRectMake(0, CGRectGetMaxY(self.view2.frame), kScreenWidth, 55);
    self.view3 = [self viewWithFrame:view3Frame left:15];
    
    
    [self.scrollView addSubview:self.view1];
    [self.scrollView addSubview:self.view5];
    [self.scrollView addSubview:self.view2];
    [self.scrollView addSubview:self.view3];


    [self.view1 addSubview:self.imagesAvatar];
    [self.view1 addSubview:self.nicknameTextField];
    [self.view1 addSubview:self.amountTextField];

    [self.imagesAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.width.height.equalTo(@(IPHONE6_W(32)));
        make.centerY.equalTo(self.view1);
    }];

    [self.nicknameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesAvatar.mas_right).offset(10);
        make.height.equalTo(@(44));
        make.width.equalTo(@(200));
        make.centerY.equalTo(self.imagesAvatar);
    }];
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.centerY.height.equalTo(self.nicknameTextField);
        make.width.equalTo(@(100));
    }];

    [self.view2 addSubview:self.imagesIcon1];
    [self.view2 addSubview:self.dataLabel];
    [self.imagesIcon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(self.view2);
    }];
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(41));
        make.centerY.equalTo(self.imagesIcon1);
    }];

    [self.view3 addSubview:self.imagesIcon2];
    [self.view3 addSubview:self.remarkTextField];
    [self.imagesIcon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(self.view3);
    }];
    [self.remarkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(41));
        make.centerY.equalTo(self.imagesIcon2);
        make.height.equalTo(@(44));
        make.right.equalTo(self.view.mas_right).offset(-15);
    }];

    [self.scrollView addSubview:self.collectionView];
//    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.view3.frame), kScreenWidth, 120);

    
    /// 计算 collectionView 高度
    CGFloat margin = 15+5;
    CGFloat spacing = 0*2;
    CGFloat widht = (kScreenWidth-margin-spacing)/3.0;
    CGFloat idx = self.imagesPhotosArray.count/3.0;
    NSInteger idxs = (int)ceilf(idx);
    CGFloat f_height = 0.0;
    if (idxs==1)f_height=20.0;
    CGFloat collectionHeight = idxs*widht+f_height;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(CGRectGetMaxY(self.view3.frame)));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(IPHONE6_W(collectionHeight)));
    }];
    
    CGFloat f = 0.0;
    if (self.idxType==2) {
        self.view4 = [UIView lz_viewWithColor:kClearColor];
        [self.scrollView addSubview:self.view4];
        [self.view4 addSubview:self.imagesIcon3];
        [self.view4 addSubview:self.deleteButton];
        [self.view4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(55));
        }];
        
        [self.imagesIcon3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerX.equalTo(self.imagesIcon1);
            make.centerY.equalTo(self.view4);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dataLabel);
            make.centerY.equalTo(self.imagesIcon3);
            make.right.equalTo(self.view.mas_right).offset(-15);
            make.height.equalTo(@(44));
        }];
        f = CGRectGetMaxY(self.view3.frame) + collectionHeight + CGRectGetHeight(self.view3.frame)+50;
    }else{
        f = CGRectGetMaxY(self.view3.frame) + collectionHeight + 50;
    }

    TTLog(@"%f",f);
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, f);

    [self.view addSubview:self.titleView];
}

- (void) handleButtonTapped:(UIButton *)sender{
    Toast([sender currentTitle]);
}

- (void) initViewConstraints{
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(kNavBarHeight));
        make.height.equalTo(@(44));
    }];
}

- (void)SCSegmentTitleView:(SCSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    if (endIndex==2) {
        self.view5.height = 112;
        self.view2.y = CGRectGetMaxY(self.view5.frame);
    }
    TTLog(@"endIndex -- %ld",(long)endIndex);
}


#pragma mark ---- UICollectionViewDataSource
// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesPhotosArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCPublishPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kClearColor;
    self.indexPath = indexPath;
    cell.imagesView.tag = [indexPath item];
    [cell.imagesView setImage:self.imagesPhotosArray[indexPath.item]];
    if (indexPath.row==self.imagesPhotosArray.count-1) {
        cell.imagesDelButton.hidden = YES;
    }else{
        cell.imagesDelButton.hidden = NO;
    }
    
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.imagesView.userInteractionEnabled = YES;
    [cell.imagesView addGestureRecognizer:singleTap];
    cell.imagesDelButton.tag = [indexPath item];
    [cell.imagesDelButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    return cell;
}

#pragma mark - 图片cell点击事件
//点击图片看大图
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
//    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
//    NSInteger index = tableGridImage.tag;
    [self.imagesPhotosArray addObject:@"WechatIMG8_hd"];
    //    [self selectPhoto];
}

#pragma mark ---- 选择图片 ----
- (void) selectPhoto{
    MV(weakSelf)
    LZActionSheet *actionSheet = [[LZActionSheet alloc] initWithTitle:@"选择图片"
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@""
                                                    otherButtonTitles:@[@"从手机相册选择"]
                                                     actionSheetBlock:^(NSInteger buttonIndex) {
                                                         [weakSelf clickedButtonAtIndex:buttonIndex];
                                                     }];
    [actionSheet showView];
}

- (void) clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSInteger maxCount = 9;
    NSInteger column = 4;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount
                                                                                        columnNumber:column
                                                                                            delegate:self
                                                                                   pushPhotoPickerVc:YES];
    imagePickerVc.isSelectOriginalPhoto = YES;
    if (maxCount > 1) {
        // 1.设置目前已经选中的图片数组
        //        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
    imagePickerVc.allowPickingVideo = NO;           /// 是否可以选择视频
    imagePickerVc.allowPickingImage = YES;          /// 是否可以选择图片
    imagePickerVc.allowPickingOriginalPhoto = YES;  /// 是否可以选择原图
    imagePickerVc.allowPickingGif = NO;             /// 是否可以选择Gif
    imagePickerVc.allowPickingMultipleVideo = NO;   /// 是否可以多选视频
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.showSelectBtn = NO;   /// 是否显示按钮
    imagePickerVc.allowCrop = NO;       /// 是否可以裁剪
    imagePickerVc.needCircleCrop = NO;  /// 是否需要圆形裁剪
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = YES;
    
    
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [self.imagesPhotosArray removeAllObjects];
        
        [self.imagesPhotosArray addObjectsFromArray:photos];
        //        [self uploadMultipleImageRequest:self.selectedPhotos];
        [self.imagesPhotosArray addObject:kGetImage(@"live_btn_publish_last")];
        [self.collectionView reloadData];
    }];
    
    //    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    NSInteger idx = sender.tag;
    [self.imagesPhotosArray removeObjectAtIndex:idx];
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:idx inSection:0]]];
    for (NSInteger item = idx; item <= self.imagesPhotosArray.count; item++) {
        SCPublishPictureCell *cell = (SCPublishPictureCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
        cell.imagesDelButton.tag--;
        cell.imagesView.tag--;
    }
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    [self.collectionView reloadData];
}

/// 更新CollectionViewHeight
- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.endHeight != height) {
        self.endHeight = height;
        self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.view3.frame), self.collectionView.width, height);
        self.view4.y = CGRectGetMaxY(self.collectionView.frame);
    }
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark ---- setter/getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat margin = 15+5;
        CGFloat spacing = 0*2;
        CGFloat widht = (kScreenWidth-margin-spacing)/3;
        //确定item的大小
        flowLayout.itemSize = CGSizeMake(widht, widht);
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 0;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 0;
        //确定距离上左下右的距离
        flowLayout.sectionInset = UIEdgeInsetsMake(15,15,15,5);
        //头尾部高度
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = kWhiteColor;
        [_collectionView registerClass:[SCPublishPictureCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

- (NSMutableArray *)imagesPhotosArray{
    if (!_imagesPhotosArray) {
        _imagesPhotosArray = [[NSMutableArray alloc] init];
        [_imagesPhotosArray addObject:kGetImage(@"WechatIMG8_hd")];
        [_imagesPhotosArray addObject:kGetImage(@"WechatIMG8_hd")];
        [_imagesPhotosArray addObject:kGetImage(@"WechatIMG8_hd")];
        [_imagesPhotosArray addObject:kGetImage(@"WechatIMG8_hd")];
        [_imagesPhotosArray addObject:kGetImage(@"WechatIMG8_hd")];
        [_imagesPhotosArray addObject:kGetImage(@"WechatIMG8_hd")];
        [_imagesPhotosArray addObject:kGetImage(@"WechatIMG8_hd")];
        [_imagesPhotosArray addObject:kGetImage(@"WechatIMG8_hd")];
        [_imagesPhotosArray addObject:kGetImage(@"tools_btn_add")];
    }
    return _imagesPhotosArray;
}

- (NSMutableArray *)selectedAssets{
    if (!_selectedAssets) {
        _selectedAssets = [[NSMutableArray alloc] init];
    }
    return _selectedAssets;
}



- (SCSegmentTitleView *)titleView{
    if (!_titleView) {
        NSArray *titleArray = @[@"婚照",@"婚礼",@"礼服",@"婚品",@"其他"];
        _titleView = [[SCSegmentTitleView alloc]initWithFrame:CGRectMake(0,0,0,0)
                                                       titles:titleArray
                                                     delegate:self indicatorType:SCIndicatorTypeEqualTitle];
        _titleView.titleFont = kFontSizeMedium14;
        _titleView.titleSelectFont = kFontSizeMedium14;
        _titleView.titleNormalColor = kColorWithRGB(255, 198, 209);
        _titleView.titleSelectColor = kWhiteColor;
        _titleView.indicatorColor = kWhiteColor;
        _titleView.selectIndex = 0;
        _titleView.backgroundColor = kColorWithRGB(255, 65, 99);
    }
    return _titleView;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kFontSizeMedium15;
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setBackgroundImage:imageColor(kColorWithRGB(255, 65, 99)) forState:UIControlStateNormal];
        MV(weakSelf);
        [_saveButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.saveButton];
        }];
    }
    return _saveButton;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        CGFloat y = CGRectGetMaxY(self.titleView.frame);
        CGRect frame = CGRectMake(0, y, kScreenWidth, kScreenHeight-y-49);
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = kClearColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+1);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _scrollView;
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_deleteButton setTitleColor:HexString(@"#999999") forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = kFontSizeMedium12;
        [_deleteButton setTitle:@"删除账目" forState:UIControlStateNormal];
        _deleteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _deleteButton.tag = 2;
        MV(weakSelf);
        [_deleteButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.deleteButton];
        }];
    }
    return _deleteButton;
}

- (UIView *) viewWithFrame:(CGRect) frame left:(NSUInteger)left{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = kClearColor;
    
    UIView *linerView = [UIView lz_viewWithColor:kColorWithRGB(238, 238, 238)];
    [view addSubview:linerView];
    [linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.width.equalTo(@(kScreenWidth-left*2));
        make.height.equalTo(@(0.7));
        make.bottom.equalTo(view.mas_bottom);
    }];
    return view;
}

- (UIImageView *)imagesAvatar{
    if (!_imagesAvatar) {
        _imagesAvatar = [[UIImageView alloc] init];
    }
    return _imagesAvatar;
}

- (UIImageView *)imagesIcon1{
    if (!_imagesIcon1) {
        _imagesIcon1 = [[UIImageView alloc] init];
        _imagesIcon1.image = kGetImage(@"tools_btn_calendar");
    }
    return _imagesIcon1;
}

- (UIImageView *)imagesIcon2{
    if (!_imagesIcon2) {
        _imagesIcon2 = [[UIImageView alloc] init];
        _imagesIcon2.image = kGetImage(@"tools_btn_edit");
    }
    return _imagesIcon2;
}

- (UIImageView *)imagesIcon3{
    if (!_imagesIcon3) {
        _imagesIcon3 = [[UIImageView alloc] init];
        _imagesIcon3.image = kGetImage(@"tools_btn_delete");
    }
    return _imagesIcon3;
}

- (UILabel *)dataLabel{
    if (!_dataLabel) {
        _dataLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium12];
    }
    return _dataLabel;
}

- (UITextField *)nicknameTextField{
    if (!_nicknameTextField) {
        _nicknameTextField = [UITextField lz_textFieldWithPlaceHolder:@"请填写宾客姓名"];
        _nicknameTextField.returnKeyType = UIReturnKeyDone;
        _nicknameTextField.borderStyle = UITextBorderStyleNone;
        _nicknameTextField.delegate = self;
        _nicknameTextField.font = kFontSizeMedium14;
        _nicknameTextField.textColor = kTextColor102;
    }
    return _nicknameTextField;
}

- (UITextField *)amountTextField{
    if (!_amountTextField) {
        _amountTextField = [UITextField lz_textFieldWithPlaceHolder:@"0.00"];
        _amountTextField.returnKeyType = UIReturnKeyDone;
        _amountTextField.borderStyle = UITextBorderStyleNone;
        _amountTextField.textAlignment = NSTextAlignmentRight;
        _amountTextField.delegate = self;
        _amountTextField.font = kFontSizeMedium13;
        _nicknameTextField.textColor = kColorWithRGB(255, 65, 99);
    }
    return _amountTextField;
}

- (UITextField *)remarkTextField{
    if (!_remarkTextField) {
        _remarkTextField = [UITextField lz_textFieldWithPlaceHolder:@"添加备注"];
        _remarkTextField.returnKeyType = UIReturnKeyDone;
        _remarkTextField.borderStyle = UITextBorderStyleNone;
        _remarkTextField.delegate = self;
        _remarkTextField.font = kFontSizeMedium13;
    }
    return _remarkTextField;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
