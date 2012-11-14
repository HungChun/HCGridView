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

- (void)setTitle:(NSString *)title image:(UIImage *)image;

- (void)setTitle:(NSString *)title imageWithURL:(NSURL *)url;

- (void)showDeleteAnimation;

- (void)hideDeleteAnimation;

@property (nonatomic,assign) id<HCGridViewItemDelegate>selectDelegate;

/* 儲存物件資料 */
/* Save item data. */
@property (nonatomic,strong) NSDictionary *data;

/* 儲存物件id */
/* Save item id. */
@property (nonatomic) NSInteger itemID;

@end


@protocol HCGridViewItemDelegate <NSObject>

- (void)itemClicked:(HCGridViewItem *)hcGridViewItem;
- (void)itemLongTap:(HCGridViewItem *)hcGridViewItem;
- (void)itemDelete:(HCGridViewItem *)hcGridViewItem;
@end