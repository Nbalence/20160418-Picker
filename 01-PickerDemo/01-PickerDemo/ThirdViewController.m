//
//  ThirdViewController.m
//  01-PickerDemo
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ThirdViewController.h"

#define RGBMax              255.0
#define StepValue           5.0
#define RowNum              (RGBMax / StepValue) + 1

@interface ThirdViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (nonatomic)       CGFloat redNum;
@property (nonatomic)       CGFloat greenNum;
@property (nonatomic)       CGFloat blueNum;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置pickerView的数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self didSelectedRow:arc4random() % 52 inComponent:RGBTypeRed];
    [self didSelectedRow:arc4random() % 52 inComponent:RGBTypeGreen];
    [self didSelectedRow:arc4random() % 52 inComponent:RGBTypeBlue];
}

-(void)didSelectedRow:(NSInteger)row inComponent:(NSInteger)component{
    [_pickerView selectRow:row inComponent:component animated:YES];
    [self pickerView:_pickerView didSelectRow:row inComponent:component];
}


#pragma mark -UIPickerViewDataSource
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return RowNum;
}

#pragma mark -UIPickerViewDelegate

//属性字符串
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    CGFloat redValue = 0;
    CGFloat greenValue = 0;
    CGFloat blueValue = 0;
    switch (component) {
        case RGBTypeRed:
            redValue = row * StepValue / 255.0;
            break;
        case RGBTypeGreen:
            greenValue = row * StepValue / 255.0;
            break;
        case RGBTypeBlue:
            blueValue = row * StepValue / 255.0;
            break;
            
        default:
            break;
    }
    NSString *title = [NSString stringWithFormat:@"%.0f",row * StepValue];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0]}];
    return attributedString;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //取出当前列中选中的行代表的颜色取值（0.0-1.0）
    CGFloat num = row * StepValue / 255.0;
    switch (component) {
        case RGBTypeRed:
            _redNum = num;
            break;
        case RGBTypeGreen:
            _greenNum = num;
            break;
        case RGBTypeBlue:
            _blueNum = num;
            break;
            
        default:
            break;
    }
    _colorView.backgroundColor = [UIColor colorWithRed:_redNum green:_greenNum blue:_blueNum alpha:1.0];
}

@end
