//
//  ViewController.m
//  YQQCalendar
//
//  Created by zhuyi on 2020/11/12.
//

#import "ViewController.h"
#import "YQQCalender.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    YQQCalender *calendar = [[YQQCalender alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:calendar];
}


@end
