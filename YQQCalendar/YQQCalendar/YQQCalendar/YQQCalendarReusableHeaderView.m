//
//  YQQCalendarReusableHeaderView.m
//  YQQCalendar
//
//  Created by zhuyi on 2020/11/12.
//

#import "YQQCalendarReusableHeaderView.h"
#import "NSDate+YQQAdd.h"
#import "YQQCalendarModel.h"

@interface YQQCalendarReusableHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YQQCalendarReusableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(16, (self.frame.size.height - 21) / 2.0, self.frame.size.width - 32, 21);
}

- (void)setModel:(YQQCalendarModel *)model {
    _model = model;
    _titleLabel.text = [_model.date stringWithFormat:@"yyyy年MM月"];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    }
    return _titleLabel;
}

@end
