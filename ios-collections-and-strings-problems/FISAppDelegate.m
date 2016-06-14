//  FISAppDelegate.m

#import "FISAppDelegate.h"

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSUInteger number = 6743011;
    NSArray *arrayOfDigits = [self arrayOfDigitsInNumber:number];
    NSLog(@"These are the digits in %lu: %@", number, arrayOfDigits);
    
    NSArray *tastyDrinks = @[@"Vesper", @"Negroni", @"Tuxedo", @"Manhattan", @"Sazerac", @"Vieux Carre"];
    [self printWordsInFrame:tastyDrinks];
    
    NSString *makeMePigLatin = @"MaKe Me PiG LaTiN";
    NSLog(@"%@",[self translateToPigLatin:makeMePigLatin]);
    
    NSString *tigger = @"My name is Tigger";
    NSLog(@"%@", [self translateToPigLatin:tigger]);
    
    NSArray *fruits = @[@"apple", @"banana", @"orange", @"kiwi", @"watermelon", @"mango"];
    NSArray *veggies = @[@"asparagus", @"broccoli", @"carrots"];
    [self alternateList:fruits withList:veggies];
    
    NSMutableArray *mFruits = [fruits mutableCopy];
    NSLog(@"This is the reversed list of fruits: %@", [self reverseArray:mFruits]);
    return YES;
}

-(void)printWordsInFrame:(NSArray *)words {
    // Determine the longest word in the array:
    NSString *longestWord = @"";
    for (NSString *word in words) {
        if (word.length > longestWord.length) {
            longestWord = word;
        }
    }
    
    // Set frame width to the longest word's length plus 4. You need 4 additional characters to cover the corners and the spaces between each word and the vertical edges of the frame.
    NSUInteger frameWidth = longestWord.length;
    NSString *frameTopAndBottom = @"";
    while (frameTopAndBottom.length < frameWidth + 4) {
        frameTopAndBottom = [frameTopAndBottom stringByAppendingString:@"*"];
    }
    NSLog(@"%@", frameTopAndBottom);
    
    // Iterate over the array of words to make each string the same length as the longest word, by adding spaces to the right. Then add the vertical edges and return to the next line after each word.
    for (NSUInteger i = 0; i < [words count]; i++) {
        NSString *word = words[i];
        while (word.length < frameWidth) {
            word = [word stringByAppendingString:@" "];
        }
        NSLog(@"* %@ *\n", word);
    }
    NSLog(@"%@", frameTopAndBottom);
}


-(NSString *)translateToPigLatin:(NSString *)string {
    // Create an array of words from the argument string.
    NSArray *wordsInString = [string componentsSeparatedByString:@" "];
    NSString *pigLatinTranslation = @"";
    
    // Iterate over the array of words. For each word, capture the first letter, then remove the first letter, then reattach it at the end of the word with -ay.
    for (NSString *word in wordsInString) {

        NSString *firstLetter = [word substringToIndex:1];
        NSString *wordWithoutFirstLetter = [word substringFromIndex:1];
        
        // Check to see if the word is capitalized. If so, make first letter lowercase and capitalize word once the first letter has been removed.
        if ([firstLetter.uppercaseString isEqualToString:firstLetter]) {
            firstLetter = firstLetter.lowercaseString;
            wordWithoutFirstLetter = wordWithoutFirstLetter.capitalizedString;
        }
        NSString *wordInPigLatin = [wordWithoutFirstLetter stringByAppendingFormat:@"%@ay", firstLetter];
        pigLatinTranslation = [pigLatinTranslation stringByAppendingFormat:@"%@ ", wordInPigLatin];
    }
    NSLog(@"This is the pig latin translation: %@", pigLatinTranslation);
    return pigLatinTranslation;
}


-(NSArray *)alternateList:(NSArray *)listOne withList:(NSArray *)listTwo {
    NSMutableArray *alternatingList = [[NSMutableArray alloc]init];
    
    // Scenario A: The first argument listOne contains more objects than listTwo. We want to preserve listOne objects at indices that exceed the bounds of listTwo, and add them back at the end of the concatenated alternating list.
    if ([listOne count] >= [listTwo count]) {
        
        NSMutableArray *listOneTail = [[NSMutableArray alloc]init];
        for (NSUInteger i = [listTwo count]; i < [listOne count]; i++) {
            [listOneTail addObject:listOne[i]];
        }
        
        for (NSUInteger i = 0; i < [listTwo count]; i++) {
            [alternatingList addObject:listOne[i]];
            [alternatingList addObject:listTwo[i]];
        }
        [alternatingList addObjectsFromArray:listOneTail];
    
    // Scenario B: The second argument listTwo contains more objects than listOne. Again, save objects from longer listTwo in a "listTwoTail" array, then append this to the end of the concatenated alternating list.
    
    } else if ([listTwo count] > [listOne count]) {
        
        NSMutableArray *listTwoTail = [[NSMutableArray alloc]init];
        for (NSUInteger i = [listOne count]; i < [listTwo count]; i++) {
            [listTwoTail addObject:listTwo[i]];
        }
        for (NSUInteger i = 0; i < [listOne count]; i++) {
            [alternatingList addObject:listOne[i]];
            [alternatingList addObject:listTwo[i]];
        }
        [alternatingList addObjectsFromArray:listTwoTail];
    }
    NSLog(@"This is the concatenated alternating array: %@", alternatingList);
    return alternatingList;
}


-(NSArray *)arrayOfDigitsInNumber:(NSUInteger)number {
    NSString *intToString = [NSString stringWithFormat:@"%lu", number];
    
    // Modulo ten returns the lowest place digit. Ie, when you divide by ten, the remainder is the lowest place digit. Capture the return in a variable 'digit', then divide the number by ten in order to access the digit at the next greatest place.
    NSMutableArray *listOfDigits = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i < intToString.length; i++) {
        NSUInteger digit = number % 10;
        number /= 10;
        [listOfDigits insertObject:@(digit) atIndex:0];
    }
    return listOfDigits;
}


-(NSMutableArray *)reverseArray:(NSMutableArray *)array {
    
    // Method implementation assumes that argument array is populated with NSString objects. You could adjust easily for any other object type.
    for (NSUInteger i = 0; i < array.count/2; i++) {
        NSString *frontObject = array[i];
        NSString *backObject = array[array.count - (i+1)];
        [array replaceObjectAtIndex:i withObject:backObject];
        [array replaceObjectAtIndex:array.count - (i+1) withObject:frontObject];
    }
    return array;
}


@end
