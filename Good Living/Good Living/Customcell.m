//
//  Customcell.m
//  Usoci_App
//
//  Created by Nanostuffs's Macbook on 05/06/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "Customcell.h"

@implementation Customcell
@synthesize str,str1,btn1,customView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            
            str=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 30)];
            str.backgroundColor = [UIColor clearColor];
            str.textColor=[UIColor blackColor];
            str.lineBreakMode=NSLineBreakByWordWrapping;
            str.numberOfLines=0;
            
            [self addSubview:str];
            
            str1=[[UILabel alloc]initWithFrame:CGRectMake(160, 5, 180, 30)];
            str1.backgroundColor = [UIColor clearColor];
            str1.textColor=[UIColor colorWithRed:237/255.0f green:35/255.0f blue:176/255.0f alpha:1.0f];
           // str1.lineBreakMode=NSLineBreakByWordWrapping;
            str1.numberOfLines=0;
            
                    [self addSubview:str1];
            
            [str setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0]];
            [str1 setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
        }
        else
        {
            
            str=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 230, 60)];
            str.backgroundColor = [UIColor clearColor];
            str.textColor=[UIColor blackColor];
            str.lineBreakMode=NSLineBreakByWordWrapping;
            str.numberOfLines=0;
            
            [self addSubview:str];
            
            str1=[[UILabel alloc]initWithFrame:CGRectMake(270, 10, 320, 60)];
            str1.backgroundColor = [UIColor clearColor];
            str1.textColor=[UIColor colorWithRed:237/255.0f green:35/255.0f blue:176/255.0f alpha:1.0f];
            str1.lineBreakMode=NSLineBreakByWordWrapping;
            str1.numberOfLines=0;
                        
            [str setFont:[UIFont fontWithName:@"Helvetica Neue" size:26.0]];
            [str1 setFont:[UIFont fontWithName:@"Helvetica Neue" size:26.0]];
                    [self addSubview:str1];
        }

  
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
