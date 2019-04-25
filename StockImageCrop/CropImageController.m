//
//  CropImageController.m
//  StockImageCrop
//
//  Created by vpjacob on 2019/4/13.
//  Copyright © 2019年 ca. All rights reserved.
//

#import "CropImageController.h"
#import "CropperView.h"
#import "CommonUtil.h"
static CGFloat const BottomViewHeight = 50.0;
@interface CropImageController ()
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView *redView;

@property (nonatomic, strong) CropperView *imageCropperView;

@property (nonatomic, copy) void(^doneBlock)(NSArray *imageArray);

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, assign) CGRect rect;

@end

@implementation CropImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.scrollView];
    [self configuationView];
}

- (void)configuationView {
    self.flag = YES;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat left = 50;
//
//    CGFloat cropWidth = screenWidth - left * 2.0;
//    CGRect rect = CGRectMake(left, (screenHeight - BottomViewHeight) / 2.0 - 100, cropWidth, 100);
//    self.rect = rect;
//
//    self.imageCropperView = [[CropperView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - BottomViewHeight) image:_originalImage rectArray:@[NSStringFromCGRect(rect)]];
//    CGFloat width = self.view.bounds.size.width;
//    CGFloat scal = self.originalImage.size.width / self.view.bounds.size.width;
//    CGFloat height = self.originalImage.size.height / scal;
//
//    self.imageCropperView.contentSize = CGSizeMake(width, height);
//    [self.view addSubview:_imageCropperView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight - BottomViewHeight - TabbarSafeBottomMargin, screenWidth, BottomViewHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.userInteractionEnabled = YES;
    
    CGFloat buttonTop = 10;
    CGFloat buttonHeight = BottomViewHeight - buttonTop * 2;
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, buttonTop, 50, buttonHeight);
    [cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.backgroundColor = [UIColor clearColor];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor colorWithRed:63 / 255.0 green:187 / 255.0 blue:155 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [bottomView addSubview:cancleButton];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake((screenWidth - 50) / 2.0, buttonTop, 50, buttonHeight);
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setImage:[UIImage imageNamed:@"chapter_plus_green"] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:addButton];
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    photoButton.frame = CGRectMake(screenWidth - 50, buttonTop, 50, buttonHeight);
    [photoButton addTarget:self action:@selector(photo) forControlEvents:UIControlEventTouchUpInside];
    photoButton.backgroundColor = [UIColor clearColor];
    [photoButton setImage:[UIImage imageNamed:@"cut"] forState:UIControlStateNormal];
    [photoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:photoButton];
    
    [self.view addSubview:bottomView];
}

- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)add:(UIButton *)button {
    
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.redView.backgroundColor = [UIColor clearColor];
//    self.view.backgroundColor = [UIColor greenColor];
    self.redView.layer.borderColor = UIColor.redColor.CGColor;
    self.redView.layer.borderWidth = 1;
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.redView addGestureRecognizer:panGestureRecognizer];

    
    [self.scrollView addSubview: self.redView];

    
//    if (_flag) {
//        [button setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
//        [_imageCropperView addCropRect:CGRectMake(CGRectGetMinX(_rect), CGRectGetMaxY(_rect) + 10, CGRectGetWidth(_rect), CGRectGetHeight(_rect))];
//    } else {
//        [button setImage:[UIImage imageNamed:@"chapter_plus_green"] forState:UIControlStateNormal];
//        [_imageCropperView removeCropRectByIndex:1];
//    }
//    _flag = !_flag;
}

- (void)panGesture:(UIPanGestureRecognizer *)sender{
//返回在横坐标上、纵坐标上拖动了多少像素
  
CGPoint point=[sender translationInView:self.scrollView];
  
NSLog(@"%f,%f",point.x,point.y);
    double pointX = self.redView.frame.size.width+point.x;
    double pointY = self.redView.frame.size.height+point.y;
    if (pointX < 20|| pointY<20) {
        return;
    }
    if (pointX > self.scrollView.bounds.size.width|| pointY>self.scrollView.bounds.size.width) {
        return;
    }

    sender.view.center=CGPointMake(pointX, pointY);
    self.redView.frame = CGRectMake(0, 0, self.redView.frame.size.width + point.x, self.redView.frame.size.height + point.y);
//拖动完之后，每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
  
[sender setTranslation:CGPointMake(0, 0) inView:self.view];
    
    
}

- (void)photo {
    if (self.doneBlock) {
        self.doneBlock([self.imageCropperView cropedImageArray]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done:(void(^)(NSArray *imageArray))done {
    self.doneBlock = done;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        CGFloat width = self.view.bounds.size.width;
        CGFloat scal = self.originalImage.size.width / self.view.bounds.size.width;
        CGFloat height = self.originalImage.size.height / scal;

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, width, self.view.bounds.size.height - 64)];
        _scrollView.contentSize = CGSizeMake(width, height);
        _scrollView.scrollEnabled = YES;
        [_scrollView addSubview:self.imageView];
    }
    return _scrollView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:self.originalImage];
        _imageView.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    }
    return _imageView;
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
