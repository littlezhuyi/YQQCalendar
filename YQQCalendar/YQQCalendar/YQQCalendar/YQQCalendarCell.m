//
//  YQQCalendarCell.m
//  YQQCalendar
//
//  Created by zhuyi on 2020/11/12.
//

#import "YQQCalendarCell.h"
#import "NSDate+YQQAdd.h"

@interface YQQCalendarCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YQQCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setItem:(YQQCalendarItem *)item {
    _item = item;
    if (_item.date) {
        _titleLabel.text = [NSString stringWithFormat:@"%ld", _item.date.day];
        if (_item.selectedType == YQQCalendarItemSelectedTypeNone) {
            _titleLabel.backgroundColor = [UIColor clearColor];
        } else if (_item.selectedType == YQQCalendarItemSelectedTypeMiddle) {
            _titleLabel.backgroundColor = [UIColor orangeColor];
        } else {
            _titleLabel.backgroundColor = [UIColor redColor];
        }
    } else {
        _titleLabel.text = @"";
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, (self.frame.size.height - 21) / 2.0, self.frame.size.width, 21);
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
