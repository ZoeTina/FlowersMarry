//
//  SCImagePicker.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCImagePicker.h"
#import "SCUploadImageModel.h"

@interface SCImagePicker()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak) UIViewController *controller;
@property (nonatomic,copy) void (^completionHandler)(UIImage* image,NSString *url);

@end

@implementation SCImagePicker

- (void)sc_pickWithTarget:(UIViewController *)controller completionHandler:(void (^)(UIImage *image,NSString *url))completion {
    
    self.controller = controller;
    
    self.completionHandler = completion;
    // 使用方式
    LZActionSheet *actionSheet = [[LZActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"从手机相册选择"] actionSheetBlock:^(NSInteger buttonIndex) {
        [self clickedButtonAtIndex:buttonIndex];
    }];
    [actionSheet showView];
}

/** 选择拍照还是从相册中选择 */
- (void) clickedButtonAtIndex:(NSInteger)buttonIndex{
    MV(weakSelf)
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                //来源:相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                //来源:相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    } else {
        if (buttonIndex == 2) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面 - 获取图片选取器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = (id)self;
    imagePickerController.allowsEditing = self.isEditor;  // 打开图片后是否允许编辑
    imagePickerController.sourceType = sourceType;
    // 解决 UIImagePickerController iOS11调起相册 中的照片被导航栏遮挡
    imagePickerController.navigationBar.translucent = NO;
    imagePickerController.navigationBar.tintColor = kColorWithRGB(51, 51, 51);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.controller presentViewController:imagePickerController animated:YES completion:^{
            TTLog(@"-------------从相册中进行选择");
        }];
    });
}

#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法(图片编辑后的代理)
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadImageDataWithImage:info[UIImagePickerControllerEditedImage]];
    }];
}

/// 上传图片
- (void)uploadImageDataWithImage:(UIImage *)image {
    NSDictionary *dict = @{@"config":@"avator",@"source":@"editor"};
    [MBProgressHUD showMessage:@"" toView:self.controller.view];
    [SCHttpTools postImageWithURLString:uploadFile parameter:dict image:image success:^(id result) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        
        TTLog(@"图片上传%@",[Utils lz_dataWithJSONObject:result]);
        
        SCUploadImageModel *model = [SCUploadImageModel mj_objectWithKeyValues:result];
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (model.errcode == 0) {
                if (self.completionHandler) {
                    self.completionHandler(image,model.data.url);
                }
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }else {
            Toast(@"图片上传失败");
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        TTLog(@"图片上传 --- %@",error);
    }];
}

@end
