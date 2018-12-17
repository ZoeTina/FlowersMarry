//
//  SCPublishCommentsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCPublishCommentsViewController.h"
#import "SCPublishPictureCell.h"
#import "SCTextView.h"
#import "SCStartRating.h"
#import "TZImagePickerController.h"
#import "SCUploadImageModel.h"

static NSInteger const kRowSize = 3;
static NSString* reuseIdentifier = @"SCPublishPictureCell";
@interface SCPublishCommentsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate>

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;
@property (nonatomic, strong) SCTextView *textView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SCStartRating *startRating;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) BusinessModel *businessModel;

/// 单据
@property (nonatomic, strong) NSMutableArray *imagesPhotosArray;
@property (nonatomic, strong) NSMutableArray *imagesAssetsArray;
/// 是否已经上传了单据图
@property (nonatomic,assign) BOOL isUploaded;
/// 0:单据 1:数组
@property (nonatomic, assign) NSInteger type;

@property(nonatomic, strong) NSMutableArray *selectedPhotos;
@property(nonatomic, strong) NSMutableArray *selectedAssets;

/// 单据的URL
@property(nonatomic, copy) NSString *singlePhotosUrlString;
/// 多图的数组
@property(nonatomic, strong) NSMutableArray *multiplePhotosArray;

/// 多图的数组
@property(nonatomic, copy) NSString *scoreStr;
@property(nonatomic, copy) NSString *textViewStr;

@end

@implementation SCPublishCommentsViewController
- (id)initBusinessModel:(BusinessModel *)businessModel{
    if ( self = [super init] ){
        self.businessModel = businessModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"用户评价";
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick)];
    singleTap.numberOfTapsRequired = 1;
    self.scrollView .userInteractionEnabled = YES;
    [self.scrollView  addGestureRecognizer:singleTap];
    
    self.singlePhotosUrlString = @"";
    self.isUploaded = NO;
    // 请在设置完成最大最小的分数后再设置当前分数
    self.startRating.currentScore = 1.0f;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.startRating];
    [self.scrollView addSubview:self.lineView];
    [self.view addSubview:self.submitButton];
    [self.scrollView addSubview:self.textView];
    [self.scrollView addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame), kScreenWidth, 120);
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.collectionView.frame)+1);
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
        make.height.equalTo(@49);
        make.left.right.equalTo(self.view);
    }];
    
    MV(weakSelf)
    self.startRating.currentScoreChangeBlock = ^(CGFloat score){
        weakSelf.scoreStr = [NSString stringWithFormat:@"%.f",score];
        NSInteger idx = [weakSelf.scoreStr integerValue];
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
    if (self.textViewStr.length<10) {
        Toast(@"评价内容不能少于10个字哦~");
    }else if (self.singlePhotosUrlString.length==0){
        Toast(@"必须上传单据哦~");
    }else{
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        [parameter setObject:self.scoreStr forKey:@"level"];
        [parameter setObject:self.singlePhotosUrlString forKey:@"obille"];
        [parameter setObject:self.textViewStr forKey:@"content"];
        [parameter setObject:self.businessModel.cp_id forKey:@"cp_id"];
        [parameter setObject:self.multiplePhotosArray forKey:@"photo"];
        [self loadCommentRequest:parameter];
    }
}

- (void) loadCommentRequest:(NSMutableDictionary *)parameter{
    [SCHttpTools getWithURLString:@"comment/save" parameter:parameter success:^(id responseObject) {
        NSDictionary *results = responseObject;
        if (results) {
            if ([[results lz_objectForKey:@"errcode"] integerValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            Toast([results lz_objectForKey:@"message"]);
        }
    } failure:^(NSError *error) {
        TTLog(@"点评错误回调---- %@",error);
    }];
}

- (void) scrollViewClick{
    [kKeyWindow endEditing:YES];
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.selectedPhotos.count==0?2:self.selectedPhotos.count+1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCPublishPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell.imagesView setImage:self.imagesPhotosArray[0]];
        if (self.isUploaded) {
            cell.imagesDelButton.hidden = NO;
        }else{
            cell.imagesDelButton.hidden = YES;
        }
    }else{
        [cell.imagesView setImage:self.selectedPhotos[indexPath.item-1]];
        if (indexPath.row==self.selectedPhotos.count) {
            cell.imagesDelButton.hidden = YES;
        }else{
            cell.imagesDelButton.hidden = NO;
        }
    }
    cell.imagesView.tag = [indexPath item];
    
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
    [self.view endEditing:YES];
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == 0) {
        [self.view endEditing:YES];
        self.type = 0;
        [self selectPhoto:0];
    }else if (index==self.selectedPhotos.count){
        if (self.selectedPhotos.count>8) {
            Toast(@"已达到最大图片添加限制~");
        }else{
            self.type = 1;
            [self selectPhoto:1];
        }
    }
    [self.collectionView reloadData];
}

#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    NSInteger idx = sender.tag;
    if (idx==0) {
        self.isUploaded = NO;
        self.singlePhotosUrlString = @"";
        [self.imagesPhotosArray removeAllObjects];
        [self.imagesAssetsArray removeAllObjects];
        [self.imagesPhotosArray addObject:kGetImage(@"live_btn_publish_first")];
        [self.collectionView reloadData];
    }else{
        [self.selectedPhotos removeObjectAtIndex:idx-1];
        [self.selectedAssets removeObjectAtIndex:idx-1];
        
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:idx inSection:0]]];
        
        for (NSInteger item = idx; item <= self.selectedPhotos.count; item++) {
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
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.collectionView.frame)+120);
    }
}

#pragma mark ---- 选择图片 ----
- (void) selectPhoto:(NSInteger) type{
    MV(weakSelf)
    LZActionSheet *actionSheet = [[LZActionSheet alloc] initWithTitle:@"选择图片"
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@""
//                                                    otherButtonTitles:@[@"拍照",@"从手机相册选择"]
                                                    otherButtonTitles:@[@"从手机相册选择"]
                                                     actionSheetBlock:^(NSInteger buttonIndex) {
                                                         [weakSelf clickedButtonAtIndex:buttonIndex type:type];
                                                     }];
    [actionSheet showView];
}

- (void) clickedButtonAtIndex:(NSInteger)buttonIndex type:(NSInteger) type{
    
//    if (buttonIndex==0) {
    
//    }else if(buttonIndex ==1){
        NSInteger maxCount = type==0?1:8;
        NSInteger column = 4;
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount
                                                                                            columnNumber:column
                                                                                                delegate:self
                                                                                       pushPhotoPickerVc:YES];
        imagePickerVc.isSelectOriginalPhoto = YES;
        if (maxCount > 1) {
            // 1.设置目前已经选中的图片数组
            imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
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
            if (type==0) {
                self.isUploaded = YES;
                [self.imagesPhotosArray removeAllObjects];
                [self.imagesAssetsArray removeAllObjects];
                
                [self.imagesPhotosArray addObjectsFromArray:photos];
                [self.imagesAssetsArray addObjectsFromArray:assets];
                [self uploadSingleImageRequest:self.imagesPhotosArray[0]];
                [self.imagesPhotosArray addObject:kGetImage(@"live_btn_publish_first")];
            }else{
                [self.selectedAssets removeAllObjects];
                [self.selectedPhotos removeAllObjects];
                
                [self.selectedPhotos addObjectsFromArray:photos];
                [self.selectedAssets addObjectsFromArray:assets];
                [self uploadMultipleImageRequest:self.selectedPhotos];
                [self.selectedPhotos addObject:kGetImage(@"live_btn_publish_last")];
            }
            [self.collectionView reloadData];
        }];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
//    }
}

/// 上传图片
- (void)uploadImageDataWithImage:(UIImage *)image {
    if (self.type==0) {
        [self uploadSingleImageRequest:image];
    }else{
        [self uploadSingleImageRequest:image];
    }
}

- (void) uploadSingleImageRequest:(UIImage *)image{
    NSDictionary *dict = @{@"config":@"obill",@"source":@"editor"};
    [MBProgressHUD showMessage:@"" toView:self.view];
    [SCHttpTools postImageWithURLString:uploadFile parameter:dict image:image success:^(id result) {
        
        [MBProgressHUD hideHUDForView:self.view];
        if ([result isKindOfClass:[NSDictionary class]]) {
            SCUploadImageModel *model = [SCUploadImageModel mj_objectWithKeyValues:result];
            if (model.errcode == 0) {
                self.singlePhotosUrlString = model.data.full_url;
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }else {
            Toast(@"图片上传失败");
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        TTLog(@"图片上传 --- %@",error);
    }];
}

- (void) uploadMultipleImageRequest:(NSArray *)imagesArray{
    NSDictionary *dict = @{@"config":@"ctphoto",@"source":@"editor"};
    [MBProgressHUD showMessage:@"" toView:self.view];
    [SCHttpTools postImageArrayWithURLString:uploadFile parameter:dict imagesArray:imagesArray success:^(NSArray *result) {
        self.multiplePhotosArray = result.copy;
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSArray *errorResult) {
        TTLog(@"图片数组上传错误 --- %@",errorResult);
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

#pragma mark ----- Getter/Setter
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
        MV(weakSelf)
        _textView.textViewListening = ^(NSString *textViewStr) {
            TTLog(@"_textView监听输入的内容：%@",textViewStr);
            weakSelf.textViewStr = textViewStr;
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
        _scrollView.pagingEnabled = NO;
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

- (NSMutableArray *)selectedPhotos{
    if (!_selectedPhotos) {
        _selectedPhotos = [[NSMutableArray alloc] init];
        [_selectedPhotos addObject:kGetImage(@"live_btn_publish_last")];
    }
    return _selectedPhotos;
}
- (NSMutableArray *)selectedAssets{
    if (!_selectedAssets) {
        _selectedAssets = [[NSMutableArray alloc] init];
    }
    return _selectedAssets;
}

- (NSMutableArray *)imagesPhotosArray{
    if (!_imagesPhotosArray) {
        _imagesPhotosArray = [[NSMutableArray alloc] init];
        [_imagesPhotosArray addObject:kGetImage(@"live_btn_publish_first")];
    }
    return _imagesPhotosArray;
}
- (NSMutableArray *)imagesAssetsArray{
    if (!_imagesAssetsArray) {
        _imagesAssetsArray = [[NSMutableArray alloc] init];
    }
    return _imagesAssetsArray;
}

- (NSMutableArray *)multiplePhotosArray{
    if (!_multiplePhotosArray) {
        _multiplePhotosArray = [[NSMutableArray alloc] init];
    }
    return _multiplePhotosArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

