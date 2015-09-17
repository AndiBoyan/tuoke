//
//  JSGridViewCell.h
//  AQRule
//
//  Created by 3Vjia on 15/7/25.
//  Copyright (c) 2015年 3vjia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSGridViewCell;

@protocol JSGridViewCellDelegate
- (void)gridViewCellWasTouched:(JSGridViewCell *)gridViewCell;
@end

@interface JSGridViewCell : UIView {
    
    NSInteger row, column;
    NSString *identifier;
    
    BOOL selected;
    BOOL highlighted;
    
    id<JSGridViewCellDelegate> delegate;
    
}
@property (nonatomic, assign) id delegate;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) BOOL selected; // no using
@property (nonatomic, assign) BOOL highlighted;

@property (nonatomic, assign) NSInteger row, column;
@property (nonatomic, assign) CGRect frame;

- (id)initWithReuseIdentifier:(NSString *)identifier;

@end
