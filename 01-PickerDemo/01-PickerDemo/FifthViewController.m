//
//  FifthViewController.m
//  01-PickerDemo
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "FifthViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface FifthViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (nonatomic, strong)        NSArray *images;
@property (nonatomic)                NSInteger hardLevel;

@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation FifthViewController

//懒加载游戏图片名称
-(NSArray *)images{
    if (_images == nil) {
        _images = @[@"apple",@"bar",@"cherry",@"crown",@"lemon",@"seven"];
    }
    return _images;
}

//更改游戏难易程度
- (IBAction)selectedIndexValueChanged:(UISegmentedControl *)sender {
    _hardLevel = sender.selectedSegmentIndex + 2;
}

//开始游戏
- (IBAction)start:(UIButton *)sender {
    sender.enabled = NO;
    
    _winLabel.text = nil;
    //声明胜利的状态
    BOOL isWin = NO;
    //声明连续相同的个数
    NSInteger sameNum = 1;
    //声明上一个刷新的列的随机数
    NSInteger lastRow = 1;
    
    for (int i = 0; i < 5; i++) {
        //创建一个随机数（将要刷新的列需要选中的行）
        int rowNum = arc4random() % self.images.count;
        if (i == 0) {//对sameNum、lastRow赋初始值
            sameNum = 1;
            lastRow = rowNum;
        }else{
            //连个连续的随机数比较相同
            if (lastRow == rowNum) {
                sameNum++;
            }else{
                sameNum = 1;
            }
            lastRow = rowNum;
        }
        //1、设置胜利的状态
        if (sameNum >= _hardLevel) {
            isWin = YES;
        }
        //2、设置选中的行为上面的随机数
        [_pickerView selectRow:rowNum inComponent:i animated:YES];
    }
    
    //0、设置滚轮的声音
    NSString *crunch = [[NSBundle mainBundle] pathForResource:@"crunch" ofType:@"wav"];
    [self playSound:crunch];
    if (isWin) {
        //1、设置胜利label
        _winLabel.text = @"Win!!!!";
        //2、设置胜利的声音
        NSString *win = [[NSBundle mainBundle] pathForResource:@"win" ofType:@"wav"];
        [self playSound:win];
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changedBtnEnable:) userInfo:sender repeats:NO];
}

-(void)changedBtnEnable:(NSTimer *)timer {
    ((UIButton *)timer.userInfo).enabled = YES;
}

-(void)playSound:(NSString *)soundPath{
    NSError *error = nil;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:soundPath] error:&error];
    //分配播放所需要的资源，并且将其添加到播放队列
    [_player prepareToPlay];
    [_player play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //默认的游戏难易程度2
    _hardLevel = 2;
    _segmentedControl.selectedSegmentIndex = 0;
    
    //pickerView的数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    [self start:nil];
    // Do any additional setup after loading the view.
}

#pragma mark  -UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.images.count;
}

#pragma mark  -UIPickerDelegate
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.images[row]]];
    return imageView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 80;
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
