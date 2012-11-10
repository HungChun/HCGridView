//
//  HCGridViewItem.m
//  TestGridView
//
//  Created by HungChun on 12/11/9.
//  Copyright (c) 2012年 HungChun. All rights reserved.
//

#import "HCGridViewItem.h"
#import <QuartzCore/QuartzCore.h>

@implementation HCGridViewItem

- (id)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image
{
  self = [super initWithFrame:frame];
  if (self)
  {
    self.alpha = 0.001;
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, kHCGridViewItemImageSize, kHCGridViewItemTitleWidth, kHCGridViewItemTitleHeight)];
    _title.textAlignment = UITextAlignmentCenter;
    _title.text = title;
    [self addSubview:_title];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kHCGridViewItemImageSize, kHCGridViewItemImageSize)];
    _imageView.image = image;
    [self addSubview:_imageView];
    
    _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_deleteButton setImage:[UIImage imageNamed:@"deleteButton2.png"] forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton setUserInteractionEnabled:YES];
    [_deleteButton setHidden:YES];
    [self addSubview:_deleteButton];
    
    UITapGestureRecognizer *normalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.allowableMovement=YES;
    longPress.minimumPressDuration = 1;
    
    [normalTap requireGestureRecognizerToFail:longPress];
    
    _imageView.gestureRecognizers = [NSArray arrayWithObjects:normalTap,longPress, nil];
    _imageView.userInteractionEnabled = YES;
  }
  return self;
}

#pragma mark Public method
- (void)setTitle:(NSString *)title image:(UIImage *)image
{
  _title.text = title;
  [_imageView setImage:image];
}

- (void)showDeleteAnimation
{
  [_deleteButton setHidden:NO];
}

- (void)hideDeleteAnimation
{
  [_deleteButton setHidden:YES];
}

#pragma mark Private method
- (void)delete:(id)sender
{
  [_selectDelegate itemDelete:self];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
  return YES;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress{
  if (longPress.state == UIGestureRecognizerStateBegan)
  {
    [_selectDelegate itemLongTap:self];
  }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
  [_selectDelegate itemClicked:self];
}


@end
