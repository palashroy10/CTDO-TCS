//
//  ScheduleViewController.m
//  Agenda_CTDO
//
//  Created by TCS on 10/3/17.
//  Copyright © 2017 TCS. All rights reserved.
//

#import "ScheduleViewController.h"
#import "CollectionViewCell.h"
#import "ScheduleData.h"
#import "ScheduleMainData.h"
#import "ScheduleTableViewCell.h"
#import "ScheduleDescriptionTableViewCell.h"

@interface ScheduleViewController () {
    NSIndexPath *selectedIndexPath; //To collapse or display selected cell
    NSIndexPath *dateSelectedIndexPath; //Selected date
}

@property (nonatomic,copy) NSArray *finalScheduleArray;
@property (nonatomic, strong) Schedule *selectedDateSchedule;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedDayLabel;
@property (weak, nonatomic) IBOutlet UITableView *scheduleTableView;
@property (nonatomic,assign) NSInteger selectedRow;

- (IBAction)backBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *scheduleDateScroller;
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scheduleDateScroller.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"scrollVwBG.png"]];
//    _scheduleDateScroller.layer.shadowColor = [UIColor blackColor].CGColor;
//    _scheduleDateScroller.layer.shadowOpacity = 0.2f;
//    _scheduleDateScroller.layer.shadowOffset = CGSizeMake(10, 20);
//    _scheduleDateScroller.layer.shadowRadius = 5;
    
    self.finalScheduleArray = [[ScheduleMainData sharedInstance] getScheduledData];
    
    [self dateCellClickedAtIndex:1];
    selectedIndexPath = [NSIndexPath indexPathWithIndex:-1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//Collection view3 delegates & datasources

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.finalScheduleArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"datecell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (self.selectedRow == indexPath.row) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)200/255 blue:(CGFloat)0/255 alpha:1];
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    Schedule *mainData= (Schedule *)self.finalScheduleArray[indexPath.row];
    cell.dateLabel.text = [NSString stringWithFormat:@"%ld",(long)mainData.date];
    
    // return the cell
    return cell;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Schedule *mainData= (Schedule *)self.finalScheduleArray[indexPath.row];
    
    _selectedMonthLabel.text = mainData.month;
    _selectedDateLabel.text = [NSString stringWithFormat:@"%ld",(long)mainData.date];
    
    dateSelectedIndexPath = indexPath;
    [self dateCellClickedAtIndex:indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger rowCount = 0;
    NSInteger datesSelectedRow = dateSelectedIndexPath.row;
//    if (datesSelectedRow == 0) {
//        datesSelectedRow = 1;
//    }
    Schedule *mainData = ((Schedule *)self.finalScheduleArray[datesSelectedRow]);
    NSLog(@"MainData %@ %@",mainData,mainData.scheduleArray);
    rowCount = [mainData.scheduleArray count];
    return rowCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rowCount = 0;
    
    if (selectedIndexPath.section == section) {
        ScheduleData *scheduleData = (ScheduleData *)self.selectedDateSchedule.scheduleArray[section];
        
        if (scheduleData.name == nil || [scheduleData.name length] == 0) {
            rowCount = 1 + 3; // one header and 3 details like 1.descriptions 2. clock.
        }
        else {
            rowCount = 1 + 4; // one header and 3 details like 1.descriptions 2. clock, 3. presenter 4. meeting location
        }
    } else {
        rowCount = 1;
    }
    return rowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = 64;
    CGFloat padding = 40;
    
        ScheduleData *scheduleData = (ScheduleData *)self.selectedDateSchedule.scheduleArray[indexPath.section];
        if (indexPath.row == 0) {
            UIFont *lFont = [UIFont systemFontOfSize:18.0];
            CGFloat labelHieght = [self getLabelHeightForFont:lFont forWidth:200 andText:scheduleData.meeting];
            rowHeight = labelHieght+padding;
            if (rowHeight <= 64) {
                rowHeight = 64;
            }
        }
        if (selectedIndexPath.section == indexPath.section) {
            if (indexPath.row == 1){
                UIFont *lFont = [UIFont systemFontOfSize:17.0];
                CGFloat labelHieght = [self getLabelHeightForFont:lFont forWidth:220 andText:scheduleData.description];
                rowHeight = labelHieght+padding;
                if (rowHeight <= 64) {
                    rowHeight = 64;
                }
            } else if (indexPath.row == 2) {
                UIFont *lFont = [UIFont systemFontOfSize:17.0];
                CGFloat labelHieght = [self getLabelHeightForFont:lFont forWidth:220 andText:scheduleData.longTime];
                rowHeight = labelHieght+padding;
                if (rowHeight <= 64) {
                    rowHeight = 64;
                }
            }
            else if (indexPath.row == 3) {
                UIFont *lFont = [UIFont systemFontOfSize:17.0];
                CGFloat labelHieght = [self getLabelHeightForFont:lFont forWidth:220 andText:scheduleData.place];
                rowHeight = labelHieght+padding;
                if (rowHeight <= 64) {
                    rowHeight = 64;
                }
            }
            else if (indexPath.row == 4) {
                UIFont *lFont = [UIFont systemFontOfSize:17.0];
                CGFloat labelHieght = [self getLabelHeightForFont:lFont forWidth:220 andText:scheduleData.name];
                rowHeight = labelHieght+padding;
                if (rowHeight <= 64) {
                    rowHeight = 64;
                }
            }
        }
    return rowHeight;
}

- (CGFloat)getLabelHeightForFont:(UIFont *)font forWidth:(CGFloat)width andText:(NSString *)text
{
    if (text != nil || ![text isEqualToString:@""]) {
        CGSize constraint = CGSizeMake(width, 9999);
        CGSize size;
        
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        CGSize boundingBox = [text boundingRectWithSize:constraint
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:font}
                                                context:context].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
        
        return size.height;
    }
    else {
        return  0.0;
    }
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSInteger rowCount = 0;
//    NSInteger datesSelectedRow = dateSelectedIndexPath.row;
//    Schedule *mainData = ((Schedule *)self.finalScheduleArray[datesSelectedRow]);
//    rowCount = [mainData.scheduleArray count]+1;
//    return rowCount;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifierString = nil;

    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0) {
        identifierString = @"ScheduleCellIdentifier";
    } else {
        identifierString = @"ScheduleDescriptionCell";
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.tag = indexPath.section;
    
    ScheduleData *scheduleData = (ScheduleData *)self.selectedDateSchedule.scheduleArray[indexPath.section - 1];
    if (indexPath.row == 0) {
        ((ScheduleTableViewCell *)cell).timeLabel.text = scheduleData.time;
        ((ScheduleTableViewCell *)cell).meetingLabel.text = scheduleData.meeting;
    }
    else {
        switch (indexPath.row) {
            case 1:
            {
                ((ScheduleDescriptionTableViewCell *)cell).meetingDescriptionLabel.text = scheduleData.description;
                ((ScheduleDescriptionTableViewCell *)cell).backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
                [((ScheduleDescriptionTableViewCell *)cell).iconImageView setImage:[UIImage imageNamed:@"team"]];
                
            }
                break;
            case 2:
            {
                ((ScheduleDescriptionTableViewCell *)cell).meetingDescriptionLabel.text = scheduleData.longTime;
                ((ScheduleDescriptionTableViewCell *)cell).backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
                [((ScheduleDescriptionTableViewCell *)cell).iconImageView setImage:[UIImage imageNamed:@"team"]];
                
            }
                break;
            case 4:
            {
                ((ScheduleDescriptionTableViewCell *)cell).meetingDescriptionLabel.text = scheduleData.name;
                ((ScheduleDescriptionTableViewCell *)cell).backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
                [((ScheduleDescriptionTableViewCell *)cell).iconImageView setImage:[UIImage imageNamed:@"team"]];
            } break;
            case 3:
            {
                ((ScheduleDescriptionTableViewCell *)cell).meetingDescriptionLabel.text = scheduleData.place;
                ((ScheduleDescriptionTableViewCell *)cell).backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
                [((ScheduleDescriptionTableViewCell *)cell).iconImageView setImage:[UIImage imageNamed:@"team"]];
            } break;
            default:
                break;
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndexPath.section == indexPath.section) {
        selectedIndexPath = nil;
    }
    else {
        selectedIndexPath = indexPath;
    }
    [tableView reloadData];
}

-(void)dateCellClickedAtIndex:(NSInteger) index{
    self.selectedRow = index;
    
    UITableViewCell *cell = [self.scheduleTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    if (cell == nil) {
        self.selectedDateSchedule = self.finalScheduleArray.firstObject;
        NSLog(@"%@",self.selectedDateSchedule.scheduleArray);
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %d",cell.tag];
        NSArray *filteredArray = [self.finalScheduleArray filteredArrayUsingPredicate:predicate];
        self.selectedDateSchedule = filteredArray.firstObject;
        [self.scheduleTableView reloadData];
    }
    [self.scheduleTableView setContentOffset:CGPointMake(0, 0 - self.scheduleTableView.contentInset.top) animated:NO];
}

@end
