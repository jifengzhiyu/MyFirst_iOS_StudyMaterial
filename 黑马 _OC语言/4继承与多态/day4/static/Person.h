//
//  Person.h
//  static
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    NSString *_name;
    int _age;
}
-(void)sayHi; 
@end

NS_ASSUME_NONNULL_END
