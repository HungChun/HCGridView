//
//  ViewController.m
//  example
//
//  Created by HungChun on 12/11/10.
//  Copyright (c) 2012年 HungChun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
  _gridView = [[HCGridView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
  [_gridView setBackgroundColor:[UIColor yellowColor]];
  _gridView.selectDelegate = self;
  [self.view addSubview:_gridView];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark HCGridViewDelegate
- (void)addNewHCGridViewItem:(HCGridView *)hcGridView
{
  HCGridViewItem *item = [[HCGridViewItem alloc]initWithFrame:[hcGridView nextPosition]];
  [item setTitle:@"title" imageWithURL:nil];
  [_gridView addNewItem:item];
}

- (void)hcGridViewItemClicked:(HCGridViewItem *)item
{
  NSLog(@"item clicked");
}

- (void)hcGridViewItemDeleted:(HCGridViewItem *)item
{
  NSLog(@"item deleted");
}

@end
