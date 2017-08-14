//
//  ViewController.m
//  Music
//
//  Created by mac on 17/7/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+LBBlurredImage.h"

@interface ViewController ()

@end

@implementation ViewController{
    AVAudioPlayer *paler;
    UISlider *slider;
    
    NSInteger time;
    
    UILabel *startLab;
    
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    time=0;
    
   NSString *path = [[NSBundle mainBundle] pathForResource:@"情非得已" ofType:@"mp3"];
    
//    NSURL *url=[NSURL URLWithString:path];
    
    NSError *error=nil;
    ;
    //播放器
    
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    
    paler=[[AVAudioPlayer alloc] initWithData:data error:&error];
    
//    paler=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    
    [paler prepareToPlay
     ];
    
//    //总时间
//    NSInteger totalTime = paler.duration;
//    
//    
//    
//    NSLog(@"总时间%ld ",totalTime);
//    
    if (error!=nil) {
        NSLog(@"创建播放器错误%@",error.localizedDescription);
    }
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame=CGRectMake(100, 100, 100, 100);
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setTitle:@"播放" forState:UIControlStateNormal];
    [btn setTitle:@"暂停" forState:UIControlStateSelected];
    
    
//    [btn setBackgroundImage:[UIImage imageNamed:@"站长素材(sc.chinaz.com)-2"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    
    slider=[[UISlider alloc]initWithFrame:CGRectMake(50, 200, [UIScreen mainScreen].bounds.size.width-100, 30)];
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    
    startLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 200, 50, 30)];
    startLab.textAlignment=NSTextAlignmentRight;
    startLab.text=@"0";
    [self.view addSubview:startLab];
    
    
    UIImageView *imgVi=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    imgVi.image=[UIImage imageNamed:@"站长素材(sc.chinaz.com)-2"];
    
    //使用三方库 对图片进行模糊处理
    [imgVi setImageToBlur:[UIImage imageNamed:@"站长素材(sc.chinaz.com)-2"] blurRadius:3 completionBlock:nil];
    [self.view addSubview:imgVi];
    
//    UIBlurEffect *effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    UIVisualEffectView *effView=[[UIVisualEffectView alloc]initWithEffect:effect];
//    effView.frame=CGRectMake(0, 0, 100, 100);
//    [imgVi addSubview:effView];
    
    
}

- (void)sliderValueChange:(UISlider *)aSlider{
//    NSLog(@" %f",aSlider.value);

  paler.currentTime = aSlider.value*paler.duration;
    
    time=paler.currentTime;
}

- (void)check{
    
    
   CGFloat palyTime = paler.currentTime/paler.duration;
    
    slider.value=palyTime;
//    NSLog(@"当前播放到了%f",palyTime);
    
    time=time+1;
    
    
    NSInteger second = time%60;
    
    NSString *str=[NSString stringWithFormat:@"%ld",second];
    
    if (second<10) {
        str=[NSString stringWithFormat:@"0%ld",second];
    }
    
   NSInteger minute = (time-second)/60;
    
    NSString *str2=[NSString stringWithFormat:@"%ld",minute];
    
    if (minute<10) {
        str2=[NSString stringWithFormat:@"0%ld",minute];
    }
    
    startLab.text=[NSString stringWithFormat:@"%@:%@",str2,str];

//    [paler updateMeters];
//    
//    float afloat = [paler averagePowerForChannel:0];
//    
//    NSLog(@"%f",afloat);
    

    
}

- (void)playBtnClick:(UIButton *)btn{
    if (btn.selected==NO) {
        [paler play];
        btn.selected=YES;
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(check) userInfo:nil repeats:YES];

    }else{
        [paler pause];
        btn.selected=NO;

        if ([timer isValid]) {
            [timer invalidate];
            timer = nil;
        }
        

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
