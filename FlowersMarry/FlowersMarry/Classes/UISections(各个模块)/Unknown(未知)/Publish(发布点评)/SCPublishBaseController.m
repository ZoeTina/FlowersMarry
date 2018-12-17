//
//  SCPublishBaseController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCPublishBaseController.h"
#import "SCPublishPictureCell.h"
#import "SCTextView.h"
#import "SCStartRating.h"

#import "TZImagePickerController.h"
#import <Photos/Photos.h>

static NSInteger const kRowSize = 3;
static NSString* reuseIdentifier = @"SCPublishPictureCell";
@interface SCPublishBaseController ()<TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;
@property (nonatomic, strong) SCTextView *textView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SCStartRating *startRating;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIScrollView *scrollView;


/// 是否选择原图
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) CLLocation *location;




///////
/// 是否允许拍照 or 显示内部拍照按钮
@property (nonatomic, assign) BOOL showTakePhotoBtnSwitch;
/// 允许拍视频
@property (nonatomic, assign) BOOL showTakeVideoBtnSwitch;
/// 允许按照片修改时间升序
@property (nonatomic, assign) BOOL sortAscendingSwitch;
/// 允许选择视频
@property (nonatomic, assign) BOOL allowPickingVideoSwitch;
/// 允许选择图片
@property (nonatomic, assign) BOOL allowPickingImageSwitch;
/// 允许选择Gif图片
@property (nonatomic, assign) BOOL allowPickingGifSwitch;
/// 允许选择原图
@property (nonatomic, assign) BOOL allowPickingOriginalPhotoSwitch;
/// 显示一个ActionSheet,把拍照/拍视频按钮放在外面
@property (nonatomic, assign) BOOL showSheetSwitch;
/// 照片最大可选张数，设置为1即为单选模式
@property (nonatomic, assign) NSInteger maxCount;
/// 每行展示照片张数
@property (nonatomic, assign) BOOL columnNumberTF;
/// 单选模式下允许裁剪
@property (nonatomic, assign) BOOL allowCropSwitch;
/// 使用圆形裁剪框
@property (nonatomic, assign) BOOL needCircleCropSwitch;
/// 允许多选视频/GIF图片
@property (nonatomic, assign) BOOL allowPickingMuitlpleVideoSwitch;
/// 右上角显示图片选中序号
@property (nonatomic, assign) BOOL showSelectedIndexSwitch;

@end

@implementation SCPublishBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"用户评价";
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick)];
    singleTap.numberOfTapsRequired = 1;
    self.scrollView .userInteractionEnabled = YES;
    [self.scrollView  addGestureRecognizer:singleTap];

    
    // 请在设置完成最大最小的分数后再设置当前分数
    self.startRating.currentScore = 1.0f;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.startRating];
    [self.scrollView addSubview:self.lineView];
    [self.view addSubview:self.submitButton];
    [self.scrollView addSubview:self.textView];
    [self.scrollView addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame), kScreenWidth, self.view.height);
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.collectionView.frame)+1);

    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
        make.height.equalTo(@49);
        make.left.right.equalTo(self.view);
    }];
    
    MV(weakSelf)
    self.startRating.currentScoreChangeBlock = ^(CGFloat score){
        NSString *scoreStr = [NSString stringWithFormat:@"%.f",score];
        NSInteger idx = [scoreStr integerValue];
        switch (idx) {
            case 1:
                weakSelf.titleLabel.text = @"无力吐槽";
                break;
            case 2:
                weakSelf.titleLabel.text = @"有待改善";
                break;
            case 3:
                weakSelf.titleLabel.text = @"一般般吧";
                break;
            case 4:
                weakSelf.titleLabel.text = @"比较满意";
                break;
            case 5:
                weakSelf.titleLabel.text = @"超值服务";
                break;
        }
    };
}

- (void) handleButtonTapped:(UIButton *) sender{
    [kKeyWindow endEditing:YES];
}

- (void) scrollViewClick{
    
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArray.count+1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCPublishPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == self.imageArray.count) {
        [cell.imagesView setImage:kGetImage(@"live_btn_publish_last")];
        cell.imagesDelButton.hidden = YES;
    }else{
        NSInteger idx = indexPath.row;
        if ([self.imageArray[idx] isEqualToString:@"live_btn_publish_first"]) {
            [cell.imagesView setImage:kGetImage(@"live_btn_publish_first")];
            cell.imagesDelButton.hidden = YES;
        }else{
            [cell.imagesView setImage:kGetImage(self.imageArray[indexPath.item])];
            cell.imagesDelButton.hidden = NO;
        }
    }
    cell.imagesView.tag = [indexPath item];
    
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.imagesView .userInteractionEnabled = YES;
    [cell.imagesView  addGestureRecognizer:singleTap];
    cell.imagesDelButton.tag = [indexPath item];
    [cell.imagesDelButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
        
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    return cell;
}

#pragma mark - 图片cell点击事件
//点击图片看大图
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == 0) {
        [self.view endEditing:YES];
        //添加新图片
//        [self addNewImg];
        // 根据下标修改对应的数据
         [self.imageArray replaceObjectAtIndex:index withObject:@"base_image_tu16"];
    }else if (index==self.imageArray.count){
        if (self.imageArray.count>8) {
            Toast(@"已达到最大图片添加限制~");
        }else{
            [self.imageArray addObject:@"base_image_tu16"];
        }
    }
    [self.collectionView reloadData];
}

#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    NSInteger idx = sender.tag;

    if (idx==0) {
        [self.imageArray replaceObjectAtIndex:0 withObject:@"live_btn_publish_first"];
        [self.collectionView reloadData];
    }else{
        [_imageArray removeObjectAtIndex:idx];
        [_arrSelected removeObjectAtIndex:idx];
        
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:idx inSection:0]]];
        
        for (NSInteger item = idx; item <= _imageArray.count; item++) {
            SCPublishPictureCell *cell = (SCPublishPictureCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
            cell.imagesDelButton.tag--;
            cell.imagesView.tag--;
        }
        [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    }
}

/// 更新CollectionViewHeight
- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.endHeight != height) {
        self.endHeight = height;
        self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame), self.collectionView.width, height);
    }
}

- (void)pickerViewFrameChanged{
    
}


#pragma mark ----- Getter/Setter
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
        [_imageArray addObject:@"live_btn_publish_first"];
    }
    return _imageArray;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat margin = 15+5;
        CGFloat spacing = 0*2;
        CGFloat widht = (kScreenWidth-margin-spacing)/kRowSize;
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


- (NSMutableArray *)selectedPhotos{
    if (!_selectedPhotos) {
        _selectedPhotos = [[NSMutableArray alloc] init];
    }
    return _selectedPhotos;
}

- (NSMutableArray *)selectedAssets{
    if (!_selectedAssets) {
        _selectedAssets = [[NSMutableArray alloc] init];
    }
    return _selectedAssets;
}

- (SCTextView *)textView{
    if (!_textView) {
        _textView = [[SCTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineView.frame), kScreenWidth, 200)];
        _textView.placeholder = @"把你的感受分享给更多新人吧！至少写够10字哦~";
        _textView.placeholderColor = kTextColor153;
        _textView.borderLineColor = kClearColor;
        _textView.textColor = kTextColor51;
        _textView.textFont = kFontSizeMedium12;
        _textView.textMaxNum = 200;
        _textView.maxNumColor = kTextColor153;
        _textView.topSpace = 15.0;
        _textView.leftAndRightSpace = 15.0;
        _textView.maxNumFont = kFontSizeMedium12;
        _textView.maxNumState = SCMaxNumStateNormal;
        _textView.textViewListening = ^(NSString *textViewStr) {
            TTLog(@"_textView监听输入的内容：%@",textViewStr);
        };
    }
    return _textView;
}

- (SCStartRating *)startRating{
    if (!_startRating) {
        CGFloat left = 60;
        CGRect frame = CGRectMake(left, CGRectGetMaxY(self.titleLabel.frame)+14, kScreenWidth-left*2, 0);
        _startRating = [[SCStartRating alloc] initWithFrame:frame Count:5];
        _startRating.spacing = 27.0f;
        _startRating.checkedImage = kGetImage(@"business_shixing");
        _startRating.uncheckedImage = kGetImage(@"business_kongxing");
        _startRating.type = SCRatingTypeWhole;
        _startRating.touchEnabled = YES;
        _startRating.slideEnabled = NO;
        _startRating.maximumScore = 5.0f;
        _startRating.minimumScore = 0.0f;
    }
    return _startRating;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.frame = CGRectMake(0, 16, kScreenWidth, IPHONE6_W(15));
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView lz_viewWithColor:kLinerViewColor];
        _lineView.frame = CGRectMake(0, CGRectGetMaxY(self.startRating.frame)+19, kScreenWidth, 0.5);
    }
    return _lineView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-50);
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.frame = self.view.bounds;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = kClearColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+1);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _scrollView;
}

- (UIButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = kFontSizeMedium15;
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setBackgroundImage:imageColor(kColorWithRGB(255, 65, 99)) forState:UIControlStateNormal];
        MV(weakSelf);
        [_submitButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.submitButton];
        }];
    }
    return _submitButton;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        if (iOS7Later) {
            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}


#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    NSInteger maxCount = 9;
    NSInteger column = 4;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:column delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (maxCount > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // if (iOS7Later) {
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // }
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.iconThemeColor = kColorWithRGB(31, 185, 34);
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [kWhiteColor colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    /*
     [imagePickerVc setAssetCellDidSetModelBlock:^(TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView) {
     cell.contentView.clipsToBounds = YES;
     cell.contentView.layer.cornerRadius = cell.contentView.tz_width * 0.5;
     }];
     */
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;           /// 是否可以选择视频
    imagePickerVc.allowPickingImage = YES;          /// 是否可以选择图片
    imagePickerVc.allowPickingOriginalPhoto = YES;  /// 是否可以选择原图
    imagePickerVc.allowPickingGif = NO;             /// 是否可以选择Gif
    imagePickerVc.allowPickingMultipleVideo = NO;   /// 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;   /// 是否显示按钮
    imagePickerVc.allowCrop = NO;       /// 是否可以裁剪
    imagePickerVc.needCircleCrop = NO;  /// 是否需要圆形裁剪
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.width - 2 * left;
    NSInteger top = (self.view.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    // Deprecated, Use statusBarStyle
    // imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = YES;
    
    // 设置首选语言 / Set preferred language
    // imagePickerVc.preferredLanguage = @"zh-Hans";
    
    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    // imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (self.showTakeVideoBtnSwitch) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
        if (self.showTakePhotoBtnSwitch) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        if (iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:NO completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        if (self.allowCropSwitch) { // 允许裁剪,去裁剪
                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                                [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                            }];
                            imagePicker.needCircleCrop = self.needCircleCropSwitch;
                            imagePicker.circleCropRadius = 100;
                            [self presentViewController:imagePicker animated:YES completion:nil];
                        } else {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                        }
                    }];
                }];
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(NSError *error) {
                if (!error) {
                    [[TZImageManager manager] getCameraRollAlbum:YES allowPickingImage:NO needFetchAssets:NO completion:^(TZAlbumModel *model) {
                        [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:YES allowPickingImage:NO completion:^(NSArray<TZAssetModel *> *models) {
                            [tzImagePickerVc hideProgressHUD];
                            TZAssetModel *assetModel = [models firstObject];
                            if (tzImagePickerVc.sortAscendingByModificationDate) {
                                assetModel = [models lastObject];
                            }
                            [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                                if (!isDegraded && photo) {
                                    [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                                }
                            }];
                        }];
                    }];
                } else {
                    [tzImagePickerVc hideProgressHUD];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
    }
    
    /*
     // 3. 获取原图的示例，这样一次性获取很可能会导致内存飙升，建议获取1-2张，消费和释放掉，再获取剩下的
     __block NSMutableArray *originalPhotos = [NSMutableArray array];
     __block NSInteger finishCount = 0;
     for (NSInteger i = 0; i < assets.count; i++) {
     [originalPhotos addObject:@1];
     }
     for (NSInteger i = 0; i < assets.count; i++) {
     PHAsset *asset = assets[i];
     [[TZImageManager manager] getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
     finishCount += 1;
     [originalPhotos replaceObjectAtIndex:i withObject:photo];
     if (finishCount >= assets.count) {
     NSLog(@"All finished.");
     }
     }];
     }
     */
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPreset640x480 success:^(NSString *outputPath) {
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    } failure:^(NSString *errorMessage, NSError *error) {
        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a gif image, this callback will be called.
// 如果用户选择了一个gif图片，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_collectionView reloadData];
}

// Decide album show or not't
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result {
    /*
     if ([albumName isEqualToString:@"个人收藏"]) {
     return NO;
     }
     if ([albumName isEqualToString:@"视频"]) {
     return NO;
     }*/
    return YES;
}

// Decide asset show or not't
// 决定asset显示与否
- (BOOL)isAssetCanSelect:(id)asset {
    /*
     if (iOS8Later) {
         PHAsset *phAsset = asset;
         switch (phAsset.mediaType) {
            case PHAssetMediaTypeVideo: {
                // 视频时长
                // NSTimeInterval duration = phAsset.duration;
                return NO;
            } break;
            case PHAssetMediaTypeImage: {
                // 图片尺寸
                if (phAsset.pixelWidth > 3000 || phAsset.pixelHeight > 3000) {
                    // return NO;
                }
                return YES;
            } break;
            case PHAssetMediaTypeAudio:
                return NO;
            break;
            case PHAssetMediaTypeUnknown:
                return NO;
            break;
            default: break;
        }
     } else {
         ALAsset *alAsset = asset;
         NSString *alAssetType = [[alAsset valueForProperty:ALAssetPropertyType] stringValue];
         if ([alAssetType isEqualToString:ALAssetTypeVideo]) {
             // 视频时长
             // NSTimeInterval duration = [[alAsset valueForProperty:ALAssetPropertyDuration] doubleValue];
             return NO;
         } else if ([alAssetType isEqualToString:ALAssetTypePhoto]) {
             // 图片尺寸
             CGSize imageSize = alAsset.defaultRepresentation.dimensions;
             if (imageSize.width > 3000) {
                 // return NO;
             }
             return YES;
         } else if ([alAssetType isEqualToString:ALAssetTypeUnknown]) {
             return NO;
         }
     }*/
    return YES;
}

#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
//    NSString *fileName;
//    for (id asset in assets) {
//        if ([asset isKindOfClass:[PHAsset class]]) {
//            PHAsset *phAsset = (PHAsset *)asset;
//            fileName = [phAsset valueForKey:@"filename"];
//        } else if ([asset isKindOfClass:[ALAsset class]]) {
//            ALAsset *alAsset = (ALAsset *)asset;
//            fileName = alAsset.defaultRepresentation.filename;;
//        }
//        // NSLog(@"图片名字:%@",fileName);
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
