//
//  HCGridViewItem.h
//  TestGridView
//
//  Created by HungChun on 12/11/9.
//  Copyright (c) 2012年 HungChun. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHCGridViewItemImageSize 106.0f
#define kHCGridViewItemHeitht 126.0f
#define kHCGridViewItemWidth 106.0f
#define kHCGridViewItemTitleWidth 106.0f
#define kHCGridViewItemTitleHeight 20.0f
@protocol HCGridViewItemDelegate;

@interface HCGridViewItem : UIView <UIGestureRecognizerDelegate>
{
  UIButton *_deleteButton;
  UILabel *_title;
  UIImageView *_imageView;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag;

- (void)showDeleteAnimation;

- (void)hideDeleteAnimation;

@property (nonatomic,assign) id<HCGridViewItemDelegate>selectDelegate;

@property (nonatomic,strong) NSDictionary *data;

@end


@protocol HCGridViewItemDelegate <NSObject>

- (void)itemClicked:(HCGridViewItem *)hcGridViewItem;
- (void)itemLongTap:(HCGridViewItem *)hcGridViewItem;
- (void)itemDelete:(HCGridViewItem *)hcGridViewItem;
@end