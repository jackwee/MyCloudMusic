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

@property (strong,atomic)MyTableViewController *mytv;

@end

@implementation JFSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 从storyboard创建MainViewController
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.mytv = (MyTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"tableViewController"];

//    [self presentViewController:mainViewController animated:YES completion:nil];
    [self.tableView addSubview:self.mytv.view];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds] ;
    [self.scoreView setFrame:CGRectMake(0, 0, screenBounds.size.width/3.0f, 120.0f)];
    [self.orderView setFrame:CGRectMake(screenBounds.size.width/3.0f, 0, screenBounds.size.width/3.0f, 120.0f)];
    [self.earnView setFrame:CGRectMake((screenBounds.size.width/3.0f)*2.0f, 0, screenBounds.size.width/3.0f, 120.0f)];
    



}


-(void)awakeFromNib{
    [super awakeFromNib];
    CGRect screenBounds = [[UIScreen mainScreen] bounds] ;
    [self.scoreView setFrame:CGRectMake(0, 0, screenBounds.size.width/3.0f, 120.0f)];
    [self.orderView setFrame:CGRectMake(screenBounds.size.width/3.0f, 0, screenBounds.size.width/3.0f, 120.0f)];
    [self.earnView setFrame:CGRectMake((screenBounds.size.width/3.0f)*2.0f, 0, screenBounds.size.width/3.0f, 120.0f)];
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
