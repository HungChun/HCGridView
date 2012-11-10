//
//  HCGridVIew.h
//  TestGridView
//
//  Created by HungChun on 12/11/9.
//  Copyright (c) 2012年 HungChun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCGridViewItem.h"
@protocol HCGridViewDelegate;

@interface HCGridView : UIScrollView <HCGridViewItemDelegate,UIScrollViewDelegate>
{
  UIButton *_addButton;
}

@property (nonatomic,assign) id<HCGridViewDelegate>selectDelegate;

- (void)addNewItem:(HCGridViewItem *)item;

- (CGRect)nextPosition;

@end


@protocol HCGridViewDelegate <NSObject>

- (void)addNewHCGridViewItem:(HCGridView *)hcGridView;
- (void)hcGridViewItemClick:(HCGridViewItem *)item;
- (void)hcGridViewItemDelete:(HCGridViewItem *)item;

@end