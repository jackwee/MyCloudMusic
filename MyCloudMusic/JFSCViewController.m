//
//  JFSCViewController.m
//  MyCloudMusic
//
//  Created by jw-mbp on 4/23/15.
//  Copyright (c) 2015 jw-mbp. All rights reserved.
//

#import "JFSCViewController.h"
#import "MyTableViewController.h"

@interface JFSCViewController ()

@end

@implementation JFSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView addSubview:[[[MyTableViewController alloc]init]view]];
    //获得nib视图数组
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyTableView" owner:self.tableView options:nil];
    //得到第一个UIView
    UIView *tmpCustomView = [nib objectAtIndex:0];
    //获得屏幕的Frame
//    CGRect tmpFrame = [[UIScreen mainScreen] bounds];
    //设置自定义视图的中点为屏幕的中点
//    [tmpCustomView setCenter:CGPointMake(tmpFrame.size.width / 2, tmpFrame.size.height / 2)];

    [tmpCustomView setFrame:CGRectMake(self.tableView.frame.origin.x , self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    
//    printf("%f",self.tableView.frame.size.height);
//    printf("%f",self.tableView.frame.size.width);
    
    //添加视图
    [self.tableView addSubview:tmpCustomView];
    // Do any additional setup after loading the view.
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
