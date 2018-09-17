//
//  VideoTranscribeVC.m
//  ToolDemo
//
//  Created by PC-013 on 2018/8/31.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "VideoTranscribeVC.h"
#import "KLPhotoTool.h"
@interface VideoTranscribeVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController *pickeController;
@end

@implementation VideoTranscribeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.pickeController = [[UIImagePickerController alloc]init];
    self.pickeController.delegate = self;
    self.pickeController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.pickeController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    self.pickeController.videoMaximumDuration = 150;//设置最大录制时间
    self.pickeController.mediaTypes = [UIImagePickerController
                          
                          availableMediaTypesForSourceType:
                          
                          UIImagePickerControllerSourceTypeCamera];
    
    self.pickeController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    //设置清晰度
    self.pickeController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:self.pickeController animated:YES completion:^{
        }];
    });
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"info-->%@",info);
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.movie"]) {
       NSString *videoFilePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoFilePath)) {
//            UISaveVideoAtPathToSavedPhotosAlbum(videoFilePath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            [KLPhotoTool KLSaveNewVideoWithVideoPath:@[videoFilePath] WithAssetBlock:^(NSMutableArray *assetArr) {
                
            }];
            [self.pickeController dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
}
// 视频保存回调

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {
    
    NSLog(@"%@",videoPath);
    
    NSLog(@"%@",error);
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.pickeController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
