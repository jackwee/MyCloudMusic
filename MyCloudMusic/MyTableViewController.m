//
//  ViewController.m
//  MyCloudMusic
//
//  Created by jw-mbp on 4/22/15.
//  Copyright (c) 2015 jw-mbp. All rights reserved.
//

#import "MyTableViewController.h"
#import "SVPullToRefresh.h"

@interface MyTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation MyTableViewController
@synthesize listData;
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    NSArray *array = [[NSArray alloc] initWithObjects:@"Tree", @"Flower",
//                      @"Grass", @"Fence", @"House", @"Table", @"Chair",
//                      @"Book", @"Swing" , nil];
//    self.listData = array;
//}
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//    self.listData = nil;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//#pragma mark -
//#pragma mark Table View Data Source Methods
////返回行数
//- (NSInteger)tableView:(UITableView *)tableView
// numberOfRowsInSection:(NSInteger)section {
//    return [self.listData count];
//}
//
////新建某一行并返回
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
//                             TableSampleIdentifier];
//    if (cell == nil) {
////        cell = [[UITableViewCell alloc]
////                initWithStyle:UITableViewCellStyleDefault
////                reuseIdentifier:TableSampleIdentifier];
//
//    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TableSampleIdentifier];
//    }
//    
//    NSUInteger row = [indexPath row];
//    cell.textLabel.text = [listData objectAtIndex:row];
//    
//    
//    UIImage *image = [UIImage imageNamed:@"loading1@2x.png"];
//    cell.imageView.image = image;
//    UIImage *highLightedImage = [UIImage imageNamed:@"loading2@2x.png"];
//    cell.imageView.highlightedImage = highLightedImage;
//    cell.detailTextLabel.text = @"Detail Text";
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
//    
//    return cell;
//}
////#pragma mark Table Delegate Methods
////- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
////    NSUInteger row = [indexPath row];
////    return row;
////}
////- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
////    NSUInteger row = [indexPath row];
////    if (row%2 == 0) {
////        return nil;
////    }
////    return indexPath;
////
////}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSUInteger row = [indexPath row];
//    NSString *rowValue = [listData objectAtIndex:row];
//    
//    NSString *message = [[NSString alloc] initWithFormat:
//                         @"You selected %@", rowValue];
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@"Row Selected!"
//                          message:message
//                          delegate:nil
//                          cancelButtonTitle:@"Yes I Did"
//                          otherButtonTitles:nil];
//    [alert show];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
////- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
////    return 70;
////}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataSource];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak MyTableViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    //    self.tableView.showsPullToRefresh = NO;
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView triggerPullToRefresh];
}

#pragma mark - Actions

- (void)setupDataSource {
    self.dataSource = [NSMutableArray array];
    for(int i=0; i<15; i++)
        [self.dataSource addObject:[NSDate dateWithTimeIntervalSinceNow:-(i*90)]];
}

- (void)insertRowAtTop {
    __weak MyTableViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        [weakSelf.dataSource insertObject:[NSDate date] atIndex:0];
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.tableView endUpdates];
        
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    });
}


- (void)insertRowAtBottom {
    __weak MyTableViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        [weakSelf.dataSource addObject:[weakSelf.dataSource.lastObject dateByAddingTimeInterval:-90]];
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [weakSelf.tableView endUpdates];
        
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    });
}
#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    NSDate *date = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
    return cell;
}
@end
