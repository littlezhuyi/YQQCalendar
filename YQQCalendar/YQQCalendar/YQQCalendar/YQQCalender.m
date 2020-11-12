//
//  YQQCalender.m
//  YQQCalendar
//
//  Created by zhuyi on 2020/11/12.
//

#import "YQQCalender.h"
#import "YQQCalendarCell.h"
#import "YQQCalendarReusableHeaderView.h"
#import "YQQCalendarReusableFooterView.h"
#import "YQQCalendarModel.h"
#import "NSDate+YQQAdd.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScrennHeight [UIScreen mainScreen].bounds.size.height

@interface YQQCalender () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) YQQCalendarItem *selectedItem1;

@property (nonatomic, strong) YQQCalendarItem *selectedItem2;

@property (nonatomic, assign) BOOL isFirstLayout;

@end

@implementation YQQCalender

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isFirstLayout = YES;
        [self addSubview:self.collectionView];
        _startDate = [NSDate dateWithString:@"2014-09-01 00:00:00" format:@"yyyy-MM-dd HH:mm:ss"];
        _endDate = [NSDate dateWithString:@"2030-11-11 00:00:00" format:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_isFirstLayout) {
        _isFirstLayout = NO;
        self.collectionView.frame = self.bounds;
        [self refreshState];
    }
}

- (void)refreshState {
    NSInteger numberOfMonthInRange = [NSDate numberOfMonthInRange:_startDate endDate:_endDate];
        
    NSDate *firstDayOfMonth = [NSDate firstDayOfMonth:_startDate];
    
    self.dataArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < numberOfMonthInRange; i++) {
        YQQCalendarModel *model = [YQQCalendarModel new];
        model.date = [firstDayOfMonth dateByAddingMonths:i];
        NSInteger numberOfDaysInMonth = [NSDate numberOfDaysInMonth:model.date];
        NSInteger numberOfItrems = 0;
        if ((numberOfDaysInMonth == 30 && model.date.weekday == 7) || (numberOfDaysInMonth == 31 && (model.date.weekday == 7 || model.date.weekday == 6))) {
            numberOfItrems = 42;
        } else if (numberOfDaysInMonth == 28 && model.date.weekday == 1) {
            numberOfItrems = 28;
        } else {
            numberOfItrems = 35;
        }
        NSMutableArray *items = [NSMutableArray array];
        for (NSInteger j = 0; j < numberOfItrems; j++) {
            YQQCalendarItem *item = [YQQCalendarItem new];
            [items addObject:item];
            if (j < model.date.weekday - 1 || j > numberOfDaysInMonth + model.date.weekday - 2) {
                
            } else {
                item.date = [model.date dateByAddingDays:j - model.date.weekday + 1];
            }
        }
        model.items = items;
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 20);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YQQCalendarModel *model = [self.dataArray objectAtIndex:indexPath.section];
    YQQCalendarItem *item = [model.items objectAtIndex:indexPath.item];
    if (!item.date) return;
    if (self.selectedItem1 && !self.selectedItem2) {
        if ([item.date compare:self.selectedItem1.date] == NSOrderedAscending) {
            self.selectedItem1 = item;
        } else if ([item.date compare:self.selectedItem1.date] == NSOrderedSame) {
            self.selectedItem1 = item;
        } else {
            self.selectedItem2 = item;
        }
    } else {
        self.selectedItem1 = item;
        self.selectedItem2 = nil;
    }
    for (YQQCalendarModel *model in self.dataArray) {
        for (YQQCalendarItem *item in model.items) {
            if (self.selectedItem1 && !self.selectedItem2) {
                if ([item.date compare:self.selectedItem1.date] == NSOrderedSame) {
                    item.selectedType = YQQCalendarItemSelectedTypeFirst;
                } else {
                    item.selectedType = YQQCalendarItemSelectedTypeNone;
                }
            } else {
                if ([item.date compare:self.selectedItem1.date] == NSOrderedAscending) {
                    item.selectedType = YQQCalendarItemSelectedTypeNone;
                } else if ([item.date compare:self.selectedItem1.date] == NSOrderedSame) {
                    item.selectedType = YQQCalendarItemSelectedTypeFirst;
                } else if ([item.date compare:self.selectedItem2.date] == NSOrderedAscending) {
                    item.selectedType = YQQCalendarItemSelectedTypeMiddle;
                } else if ([item.date compare:self.selectedItem2.date] == NSOrderedSame) {
                    item.selectedType = YQQCalendarItemSelectedTypeLast;
                } else {
                    item.selectedType = YQQCalendarItemSelectedTypeNone;
                }
            }
        }
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    YQQCalendarModel *model = [self.dataArray objectAtIndex:section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQQCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YQQCalendarCell" forIndexPath:indexPath];
    YQQCalendarModel *model = [self.dataArray objectAtIndex:indexPath.section];
    cell.item = [model.items objectAtIndex:indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YQQCalendarModel *model = [self.dataArray objectAtIndex:indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YQQCalendarReusableHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"YQQCalendarReusableHeaderView" forIndexPath:indexPath];
        header.model = model;
        return header;
    } else {
        YQQCalendarReusableFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"YQQCalendarReusableFooterView" forIndexPath:indexPath];
        return footer;
    }
}

#pragma mark - Associated

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        NSInteger itemWidth = kScreenWidth / 7;
        CGFloat left = (kScreenWidth - itemWidth * 7) / 2.0;
        layout.sectionInset = UIEdgeInsetsMake(0, left, 0, left);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        [_collectionView registerClass:[YQQCalendarCell class] forCellWithReuseIdentifier:@"YQQCalendarCell"];
        [_collectionView registerClass:[YQQCalendarReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YQQCalendarReusableHeaderView"];
        [_collectionView registerClass:[YQQCalendarReusableFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YQQCalendarReusableFooterView"];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
