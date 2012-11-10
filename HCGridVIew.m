//
//  HCGridVIew.m
//  TestGridView
//
//  Created by HungChun on 12/11/9.
//  Copyright (c) 2012年 HungChun. All rights reserved.
//

#define kAddButtonDefaultRect CGRectMake(0, 0, 106, 126)
#define kColumnCount 3
#import "HCGridVIew.h"

@implementation HCGridView
{
  NSMutableArray *_items;
  BOOL _isDelete;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _isDelete = NO;
    self.delegate = self;
    [self setContentSize:CGSizeMake(frame.size.width, frame.size.width)];
    _items = [[NSMutableArray alloc]init];
    _addButton = [[UIButton alloc]initWithFrame:kAddButtonDefaultRect];
    [_addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
  }
  return self;
}

- (void)didAddSubview:(UIView *)subview
{
  [super didAddSubview:subview];
  if ([subview class] == [HCGridViewItem class])
  {
    NSLog(@"didAddSubview");
    [self reLayoutView];
  }
}
#pragma mark Public method

- (void)addNewItem:(HCGridViewItem *)item
{
  [item setTag:_items.count];
  item.selectDelegate = self;
  [_items addObject:item];
  [UIView animateWithDuration:0.3 animations:^{
    item.alpha = 1.0f;
    [self addSubview:item];
  }];
}

- (CGRect)nextPosition
{
  return _addButton.frame;
}

#pragma mark Private method
- (void)reLayoutView
{
  __block CGFloat delay = 0.2;
  __block NSInteger count = _items.count;
  if ([_items count] == 0)
    [UIView animateWithDuration:0.3 animations:^{
      [_addButton setFrame:kAddButtonDefaultRect];
    }];
  [_items enumerateObjectsUsingBlock:^(HCGridViewItem *item, NSUInteger idx, BOOL *stop) {
    if (idx == 0) 
      delay = 0.2;
    item.tag = idx;
    CGFloat itemX = item.frame.origin.x;
    CGFloat itemY = item.frame.origin.y;
    
    CGFloat itemNewX = (idx % ( kColumnCount )) * kHCGridViewItemWidth;
    CGFloat itemNewY = (idx / ( kColumnCount )) * kHCGridViewItemHeitht;
    
    if (itemX != itemNewX || itemY != itemNewY)
    {
      [UIView animateWithDuration:delay animations:^{
        [item setFrame:CGRectMake(itemNewX, itemNewY, kHCGridViewItemWidth, kHCGridViewItemHeitht)];
      }];
      delay += 0.03;
    }
    if (idx + 1 == count)
    {
      [UIView animateWithDuration:0.3 animations:^{
        [_addButton setFrame:CGRectMake((count % ( kColumnCount )) * kHCGridViewItemWidth, (count / ( kColumnCount )) * kHCGridViewItemHeitht, kHCGridViewItemWidth, kHCGridViewItemHeitht)];
      }];
    }
    if (!_isDelete)
    {
      if (count >= 9)
      {
        [self setContentSize:CGSizeMake(_addButton.frame.origin.x, _addButton.frame.origin.y + kHCGridViewItemHeitht)];
        [self setContentOffset:CGPointMake(0, _addButton.frame.origin.y + kHCGridViewItemHeitht - self.frame.size.height)];
      }
    }
  }];
}

- (void)setDeleteState
{
  if (_isDelete)
  {
    [_items enumerateObjectsUsingBlock:^(HCGridViewItem *item, NSUInteger idx, BOOL *stop) {
      [item hideDeleteAnimation];
    }];
    [_addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
  }
  else
  {
    [_items enumerateObjectsUsingBlock:^(HCGridViewItem *item, NSUInteger idx, BOOL *stop) {
      [item showDeleteAnimation];
    }];
    [_addButton setImage:[UIImage imageNamed:@"Done.png"] forState:UIControlStateNormal];
  }
  _isDelete =! _isDelete;
}

- (void)addButtonClick
{
  if (_isDelete)
    [self setDeleteState];
  else
    [_selectDelegate addNewHCGridViewItem:self];
}

#pragma mark HCGridViewItemDelegate
- (void)itemClicked:(HCGridViewItem *)hcGridViewItem
{
  if (!_isDelete)
    [_selectDelegate hcGridViewItemClick:hcGridViewItem];
}

- (void)itemLongTap:(HCGridViewItem *)hcGridViewItem
{
  if (!_isDelete)
    [self setDeleteState];
}

- (void)itemDelete:(HCGridViewItem *)hcGridViewItem
{
  [_items removeObject:hcGridViewItem];
  [hcGridViewItem removeFromSuperview];
  [_selectDelegate hcGridViewItemDelete:hcGridViewItem];
  [self reLayoutView];
}

@end
