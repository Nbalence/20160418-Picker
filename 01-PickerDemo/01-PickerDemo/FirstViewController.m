//
//  ViewController.m
//  01-PickerDemo
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置datePicker的取值范围
    NSDate *date = [NSDate date];
    NSDate *minDate = [date dateByAddingTimeInterval: -(60 * 60 * 24 * 3)];
    _datePicker.minimumDate = minDate;
    
    //创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //组成部分
    NSDateComponents *compenents = [[NSDateComponents alloc] init];
    compenents.year = 2016;
    compenents.month = 4;
    compenents.day = 30;
    compenents.hour = 12;
    compenents.minute = 12;
    compenents.second = 12;
    //根据组成部分从日历中获取date
    NSDate *maxDate = [calendar dateFromComponents:compenents];
    _datePicker.maximumDate = maxDate;
    
    //添加事件监听（valueChanged）
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view, typically from a nib.
}
//当_datePicker发生改变的时候触发
-(void)datePickerValueChanged:(UIDatePicker *)datePicker {
    //获取当前时区
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    //取出当前时区相对于标准时区的时间差
    NSInteger interval = [timeZone secondsFromGMTForDate:datePicker.date];
    //当前时区的时间
    NSDate *currentDate = [datePicker.date dateByAddingTimeInterval:interval];
    
    NSLog(@"%@",currentDate);
}

//显示当前选中的date
- (IBAction)selected:(UIButton *)sender {
    NSString *currentDate = [_datePicker.date descriptionWithLocale:_datePicker.locale];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:currentDate preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
