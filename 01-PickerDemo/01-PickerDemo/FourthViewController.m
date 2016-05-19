//
//  FourthViewController.m
//  01-PickerDemo
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *keys;            //左边列对应的数据
@property (nonatomic, strong) NSArray *values;          //右边列对应的数据
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end

@implementation FourthViewController

-(void)loadDictionary{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"statedictionary" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    //取出所有的键（排序）
    _keys = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    //取出第一个键对应的array
    _values = _dict[_keys.firstObject];
}

- (IBAction)selected:(UIButton *)sender {
    //取出左右两列选中的行数
    NSInteger leftSelectedRow = [_pickerView selectedRowInComponent:0];
    NSInteger rightSelectedRow = [_pickerView selectedRowInComponent:1];
    NSString *leftSelectedString  = _keys[leftSelectedRow];
    NSString *rightSelectedString = _values[rightSelectedRow];
    NSString *message = [NSString stringWithFormat:@"您选中的是%@中的%@",leftSelectedString,rightSelectedString];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDictionary];
    // Do any additional setup after loading the view.
}

#pragma mark -UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return component ? _values.count : _keys.count;
}

#pragma mark -UIPickerViewDelegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return component ? _values[row] : _keys[row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        //1、取出当前选中的行内容
        NSString *key = _keys[row];
        
        //2、用选中行内容作为键取出右边对应的values
        _values = _dict[key];
        
        //3、刷新右列
        [pickerView reloadComponent:1];
        
        //4、更改右列选中的行为0
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
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
