
//
//  KGWelcomePageViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "KGWelcomePageViewController.h"
#import "KGHomePageViewController.h"
#define KstartButtonCenterYRadio 470.f/667.f
#define KPageControlCenterYRatio 617.f/667.f
@interface KGWelcomePageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation KGWelcomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置scrollView包括图片，以及contentsize等；
    
    //scrollView填充屏幕
    //让pagecontrol处于637.f/667.f比例的位置
    _scrollView.frame=[UIScreen mainScreen].bounds;
    _pageControl.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, KPageControlCenterYRatio*[UIScreen mainScreen].bounds.size.height);
    
    
    [self setupScrollView];
    //设置点数
     _pageControl.numberOfPages=5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 设置scrollView包括图片，以及contentsize等
-(void)setupScrollView{
    for (int i=0; i<5; i++) {
        UIImageView*imageView=[[UIImageView alloc]init];
        NSString*imagname=[NSString stringWithFormat:@"introduction_%i",i+1];
        [imageView setImage:[UIImage imageNamed:imagname]];
        imageView.frame=CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        //添加按钮
        if (i==4) {
            [self addstartButton:imageView];
        }
        
       [_scrollView addSubview:imageView];
       
    }
    _scrollView.contentSize=CGSizeMake(5*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _scrollView.pagingEnabled=YES;
     _scrollView.bounces=NO;
   
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
   NSUInteger number=(NSUInteger)_scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    _pageControl.currentPage=number;
    
    
}
 //添加按钮
-(void)addstartButton:(UIImageView*)imageView{
    imageView.userInteractionEnabled=YES;
    UIButton*startButton=[[UIButton alloc]init];
    startButton.bounds=CGRectMake(0, 0, 122, 32);
    startButton.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*KstartButtonCenterYRadio);
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_nomal"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_press"] forState:UIControlStateHighlighted];
    [startButton addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    startButton.backgroundColor=[UIColor blueColor];
    [imageView addSubview:startButton];
    
}
-(void)startButtonClicked:(UIButton*)sender{
    
    //直接将主页设置为window的rootviewcontroller 这样就不会再回到欢迎页
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KGHomePageViewController*homeVC=[storyboard instantiateViewControllerWithIdentifier:@"homePage"];
    
    [UIApplication sharedApplication].keyWindow.rootViewController=homeVC;
    
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
