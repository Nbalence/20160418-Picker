//
//  SecondViewController.m
//  01-PickerDemo
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *label;


@property (nonatomic, strong) NSArray *datas;
@end

@implementation SecondViewController

//datas懒加载
-(NSArray *)datas{
    if (_datas == nil) {
        _datas = @[@"张三",@"李四",@"王五",@"赵六",@"田七",@"宋八"];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    _label.text = self.datas[2];
    // Do any additional setup after loading the view.
}

#pragma mark  -UIPickerViewDataSource
//列数
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//列中行数
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.datas.count;
}

#pragma mark -UIPickerViewDelegate
//标题
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row == 0) {
        return nil;
    }
    return self.datas[row];
}
//属性标题
- (NSAttributedString *) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.datas[row] attributes:@{NSUnderlineStyleAttributeName:@1,NSForegroundColorAttributeName:[UIColor redColor]}];
        return attributedString;
    }
    
    
    return nil;
}

-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 60;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _label.text = self.datas[row];
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
