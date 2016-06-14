//  FISAppDelegate.h

#import <UIKit/UIKit.h>

@interface FISAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)printWordsInFrame:(NSArray *)words;
-(NSString *)translateToPigLatin:(NSString *)string;
-(NSArray *)alternateList:(NSArray *)listOne withList:(NSArray *)listTwo;
-(NSArray *)arrayOfDigitsInNumber:(NSUInteger)number;
-(NSArray *)reverseArray:(NSArray *)array;

@end
