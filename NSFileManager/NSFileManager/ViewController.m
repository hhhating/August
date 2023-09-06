//
//  ViewController.m
//  NSFileManager
//
//  Created by ByteDance on 2023/8/9.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.捆绑包目录
    NSLog(@"bundlePath %@",[NSBundle mainBundle].bundlePath);
    
    // 2.沙盒主目录
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"homeDir %@",homeDir);
    
    // 3.Documents目录
    NSLog(@"Documents url %@",[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject);
    NSLog(@"Documents pathA %@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject);
    NSLog(@"Documents pathB %@",[homeDir stringByAppendingPathComponent:@"Documents"]);
    
    // 4.Library目录
    NSLog(@"Library url %@",[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject);
    NSLog(@"Library pathA %@",NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject);
    NSLog(@"Library pathB %@",[homeDir stringByAppendingPathComponent:@"Library"]);
    
    // 5.Caches目录
    NSLog(@"Caches url %@",[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].firstObject);
    NSLog(@"Caches path %@",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject);
    
    // 6.tep目录
    NSLog(@"tmpA %@",NSTemporaryDirectory());
    NSLog(@"tmpB %@",[homeDir stringByAppendingPathComponent:@"tmp"]);
    
    // 创建文件管理器
    NSFileManager *sharedFM = [NSFileManager defaultManager];
    
    // 创建NSURL类型documentsURL路径 转换为NSString类型和fileReferenceURL类型路径
    NSURL *documentsURL = [sharedFM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSLog(@"documentsURL:%@",documentsURL);
    NSLog(@"documentsURL convert to path:%@",documentsURL.path);
    NSLog(@"fileReferenceURL:%@",[documentsURL fileReferenceURL]);
    
    // 创建NSString类型libraryPath路径 转换为NSURL类型路径
    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"libraryPath:%@",libraryPath);
    NSLog(@"libraryPath convert to url:%@",[NSURL fileURLWithPath:libraryPath]);
    
    // 创建目录
    NSURL *bundleIDDir = [self applicationDirectory];
    
    // 复制目录
    [self backupMyApplicationDataWithURL:bundleIDDir];
    NSLog(@"bundleDir: %@", bundleIDDir);
    
}

// 获取应用程序的Application Support目录，并创建一个自定义目录，以存储应用程序的数据
// 创建目录
- (NSURL *)applicationDirectory {
    // 1.创建文件管理器
    NSFileManager *sharedFM = [NSFileManager defaultManager];
    
    // 2.查找Application Support目录在主目录路径
    NSArray *possibleURLs = [sharedFM URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
    
    NSURL *appSupportDir = nil;
    NSURL *dirPath = nil;
    if (possibleURLs.count > 0) {
        // 3.数组不为空时，使用第一个元素。
        appSupportDir = possibleURLs.firstObject;
    }
    
    // 4.如果存在appSupportDir目录 将应用的bundleIdentifier添加到文件结尾 用于创建自定义目录
    if (appSupportDir) {
        NSString *appBundleID = [[NSBundle mainBundle] bundleIdentifier];
        dirPath = [appSupportDir URLByAppendingPathComponent:appBundleID];
    }
    
    // 5.如果dirPath目录不存在 创建该目录
    NSError *error = nil;
    if (![sharedFM createDirectoryAtURL:dirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"Couldn't create dirPath.error %@",error);
        return nil;
    }
    return dirPath;
}
// 复制文件
- (void)backupMyApplicationDataWithURL:(NSURL *)bundleIDDir {
    NSFileManager *sharedFM = [NSFileManager defaultManager];
    
    // 1.获得源文件、备份文件路径。如果源文件不存在，则创建源文件。
    NSURL *appDataDir = [bundleIDDir URLByAppendingPathComponent:@"Data"];
    NSURL *backupDir = [appDataDir URLByAppendingPathExtension:@"backup"];
    if (![sharedFM fileExistsAtPath:appDataDir.path]) {
        if (![sharedFM createDirectoryAtURL:appDataDir withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"Couldn't create appDataDir");
            return;
        }
    }
    
    // 2.异步执行复制
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 3.使用init方法初始化文件管理器，以便后面可能用到代理方法。
        NSFileManager *theFM = [[NSFileManager alloc] init];
        NSError *anError;
        
        // 4.尝试复制文件
        if (![theFM copyItemAtURL:appDataDir toURL:backupDir error:&anError]) {
            // 5.如果复制失败，可能是backupDir已经存在，删除旧的backupDir文件
            if ([theFM removeItemAtURL:backupDir error:&anError]) {
                // 6.再次复制，如果失败，终止复制操作。
                if (![theFM copyItemAtURL:appDataDir toURL:backupDir error:&anError]) {
                    NSLog(@"anError:%@",anError);
                }
            }
        }
    });
}

@end
