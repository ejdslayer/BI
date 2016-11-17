//
//  ViewController.m
//  DeleteMe2
//
//  Created by Elliott D'Alvarez on 17/11/2016.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) BOOL bScrollUp;
@property (nonatomic) CGFloat lastContentOffset;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.bounces = NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *sIdentifier = @"fibonacciCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:sIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sIdentifier];
    }
    
    if (indexPath.row < 2)
    {
        cell.tag = 1;
    }
    else
    {
        cell.tag = [self fibonacciCalculationFromTableview:indexPath];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (NSInteger)cell.tag];
    
    return cell;
}

- (NSInteger)fibonacciCalculationFromTableview:(NSIndexPath *)indexPath
{
    NSArray *cells = self.tableView.visibleCells;

    if (self.bScrollUp)
    {
        UITableViewCell *first = cells.firstObject;
        UITableViewCell *second = [cells objectAtIndex:1];
        
        return (NSInteger)(second.tag - first.tag);
    }
    else
    {
        UITableViewCell *last = cells.lastObject;
        UITableViewCell *secondLast = [cells objectAtIndex:(cells.count - 2)];
        
        return (NSInteger)(secondLast.tag + last.tag);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.lastContentOffset > scrollView.contentOffset.y)
        self.bScrollUp = YES;
    else
        self.bScrollUp = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
