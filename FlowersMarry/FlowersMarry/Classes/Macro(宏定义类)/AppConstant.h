//
//  AppConstant.h
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/17.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#ifndef AppConstant_h
#define AppConstant_h

//// 日志打印
#ifdef DEBUG
#define TTLog(...) NSLog(@"\n\n[文件名:%s] 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define TTLog(...)
#endif

#ifdef DEBUG
# define MVLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define MVLog(...);
#endif

#define MV(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define Toast(tips) [self lz_make:tips]

// 1.RGBA
#define kColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kColorWithRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
/// RGB颜色(16进制)
//#define UIColorHexString(hexString) [Utils colorWithHexString:(hexString)]
#define UIColorHexString(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 2.clear背景颜色
#define kClearColor [UIColor clearColor]
// 3.设置随机颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

/// 随机数生成
#define kRandomNumber(number) arc4random() % number

//G－C－D
#define GLOBAL(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

///版本号
#define VERSIONing    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#define kScreenBounds   ([UIScreen mainScreen].bounds)
#define kScreenScale    [UIScreen mainScreen].scale

#define kBorderWidth1px (kScreenScale>0.0?1.0/kScreenScale:1.0)

/// 交叉后的宽度
#define kCrossScreenWidth   (kScreenWidth > kScreenHeight ?  kScreenHeight : kScreenWidth)
/// 交叉后的高度
#define kCrossScreenHeight  (kScreenWidth > kScreenHeight ?  kScreenWidth : kScreenHeight)
/// 交叉后iPhone X的宽度
#define kCrossScreenWidth_X (kScreenWidth > kScreenHeight ?  812.00 : 375.00)
/// 交叉后iPhone X的高度
#define kCrossScreenHeight_X (kScreenWidth > kScreenHeight ?  375.000 : 812.00)

#define kSafeAreaBottomHeight (kScreenHeight == 812.0 ? 34 : 0)

/** top */
#define kiPhoneX_T(f) kiPhoneX ? (f + 34) : f
/** Bottom */
#define kiPhoneX_B(f) kiPhoneX ? (kScreenHeight-34-f):(kScreenHeight-f)

#define kNavBarHeight   (kScreenHeight == 812.0 ? 88 : 64)
#define kTabBarHeight   (kScreenHeight == 812.0 ? 83 : 49)
#define kiPhoneX        ((kNavBarHeight == 88) ? YES : NO)

/** 屏幕除去navigationBar，栏目高度，tabBar之后的高度*/
#define kContentViewHeight kScreenHeight - LPPageVCSegmentHeight - 64 - 49

/// 依照iPhone6的尺寸设计
#define GETPIXEL (kScreenWidth / 375)
#define AUTOLAYOUTSIZE(size) (size * GETPIXEL)

#define systemFontOfSize(size) [UIFont systemFontOfSize:(size) * GETPIXEL]
#define boldSystemFontOfSize(size) [UIFont boldSystemFontOfSize:(size) * GETPIXEL]
/// 计算比例后的宽度
#define AUTOLAYOUTSIZE_W(w)  (w*(kScreenWidth/375.0f))
#define IPHONE6_W(x) ((kScreenWidth/375.0)*(x))
#define IPHONE6_FONT(x) [UIFont systemFontOfSize:(kScreenWidth/375.0)*(x)]
#define IPHONE6_FONT_NAME(fontName,x) [UIFont fontWithName:fontName size:(kScreenWidth/375.0)*(x)]

#define isIphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define isIpad (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
// 等比例适配系数
#define kScaleFit (isIphone ? ((kScreenWidth < kScreenHeight) ? kScreenWidth / 375.0f : kScreenWidth / 667.0f) : 1.1f)

#define imageHexString(hexString) [UIImage lz_imageWithColor:HexString(hexString)]
#define imageColor(imageColor) [UIImage lz_imageWithColor:imageColor]
#define HexString(hexString) [UIColor lz_colorWithHexString:hexString]
//16:9
#define BIGBITMAP   @"live_pic_1_placeholder"
//1:1大
#define CROSSMAPBITMAP   @"live_pic_placeholder"
/// 矩形小图
#define small_pic_placeholder   @"live_pic_placeholder"
//3:4
#define VERTICALMAPBITMAP   @"cross_4_3_PlaceImage"
#define mineAvatar   @"mine_icon_avatar"
#define imagePlaceholder   @"imagePlaceholder"

#define NetworkReachabilityStatus @"NetworkReachabilityStatus"

/// 字符串
#define     TTNoNilString(str)          (str.length > 0 ? str : @"")
/// 网络图片添加域名
#define DomainName(imageURL) [NSString stringWithFormat:@"%@",imageURL];
/// 读取本地图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
//#define kLoadImage(file,ext) [UIImage imageWithContentsOfFile:[NSBundle mainBundle] pathForResource:file ofType:ext］
/// 定义UIImage对象
//#define kImage(A) [UIImage imageWithContentsOfFile:[NSBundle mainBundle] pathForResource:A ofType:nil］
/// 图片
#define TTImage(imageName)          (imageName ? [UIImage imageNamed:imageName] : nil)
#define TTPNG(X)                    [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"png"]]
#define TTJPG(X)                    [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"jpg"]]


#define kNetworkProtocol @"http:"

#define kGetImageURL(imageURL) [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kNetworkProtocol,imageURL]]
#define kGetVideoURL(videoURL) [NSURL URLWithString:[NSString stringWithFormat:@"%@",videoURL]]

#pragma mark - # 快捷方法
/// PushVC
#define     TTPushVC(vc)                  {\
[vc setHidesBottomBarWhenPushed:YES];\
[self.navigationController pushViewController:vc animated:YES];\
}

/// 方法交换
#define     TLExchangeMethod(oldSEL, newSEL) {\
Method oldMethod = class_getInstanceMethod(self, oldSEL);\
Method newMethod = class_getInstanceMethod(self, newSEL);\
method_exchangeImplementations(oldMethod, newMethod);\
}\

/// 字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
/// 数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
/// 字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
/// 是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


#ifndef LZSYNTH_DUMMY_CLASS
#define LZSYNTH_DUMMY_CLASS(_name_) \
@interface LZSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation LZSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif

/// 移除iOS7之后，cell默认左侧的分割线边距   Preserve:保存（\：换行）
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}

/// 一些缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kUserInfo [PVUserModel shared]

/**
 取消自动适配 ScrollView 的 Insets 行为
 @param scrollView 滑动视图
 @param vc 所在控制器
 */
#define DisableAutoAdjustScrollViewInsets(scrollView, vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
if (@available(iOS 11.0,*))  {\
scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop")\
} while (0);

#endif /* AppConstant_h */
