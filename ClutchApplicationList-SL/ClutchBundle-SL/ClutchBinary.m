//
//  ClutchBinary.m
//  Clutch-SL
//
//  Created by SweetLoser on 2017/11/17.
//  Copyright © 2017年 SweetLoser. All rights reserved.
//

#import "ClutchBinary.h"
#import "ClutchBundle.h"
#import "ClutchBundleDumpOperation.h"
#import "optool.h"
#import "NSFileHandle+Private.h"

@interface ClutchBinary ()
{
    ClutchBundle *_bundle;
    BOOL _isFAT;
    BOOL _m32;
    BOOL _m64;
}
@end

@implementation ClutchBinary

-(instancetype)initWithBundle:(ClutchBundle *)bundle{
    self = [super init];
    if (self) {
        _bundle = bundle;
        if ([[_bundle.bundleContainerURL path] hasSuffix:@"Frameworks"]) {
            _frameworksPath = [_bundle.bundleContainerURL path];
        }
        NSDictionary *ownershipinfo = @{NSFileOwnerAccountName:@"mobile",NSFileGroupOwnerAccountName:@"mobile"};
        [[NSFileManager defaultManager] setAttributes:ownershipinfo ofItemAtPath:self.binaryPath error:nil];
        
        _sinfPath = [_bundle pathForResource:_bundle.executablePath.lastPathComponent ofType:@"sinf" inDirectory:@"SC_Info"];
        _supfPath = [_bundle pathForResource:_bundle.executablePath.lastPathComponent ofType:@"supf" inDirectory:@"SC_Info"];
        _suppPath = [_bundle pathForResource:_bundle.executablePath.lastPathComponent ofType:@"supp" inDirectory:@"SC_Info"];
        
        _dumpOperation = [[ClutchBundleDumpOperation alloc]initWithBundle:_bundle];
        
        NSFileHandle *tmpHandle = [[NSFileHandle alloc] initWithFileDescriptor:fileno(fopen(_bundle.executablePath.UTF8String, "r+")) closeOnDealloc:YES];
        
        NSData *headersData = tmpHandle.availableData;
        
        thin_header headers[4];
        uint32_t numHeaders = 0;
        headersFromBinary(headers, headersData, &numHeaders);
        int m32=0,m64=0;
        for (int i=0; i<numHeaders; i++) {
            thin_header macho = headers[i];
            switch (macho.header.cputype) {
                case CPU_TYPE_ARM:
                    m32++;
                    break;
                case CPU_TYPE_ARM64:
                    m64++;
                    break;
            }
        }
        
        _m32 = m32 > 1;
        _m64 = m64 > 1;
        _isFAT = numHeaders > 1;
        
        _hasRestrictedSegment = NO;
        struct thin_header macho = headers[0];
        
        unsigned long long size = [tmpHandle seekToEndOfFile];
        
        [tmpHandle seekToFileOffset:macho.offset + macho.size];
        
        for (int i=0; i<macho.header.ncmds; i++) {
            
            if (tmpHandle.offsetInFile >= size ||
                tmpHandle.offsetInFile > macho.header.sizeofcmds + macho.size + macho.offset){
                break;
            }
            uint32_t cmd = [tmpHandle intAtOffset:tmpHandle.offsetInFile];
            uint32_t size = [tmpHandle intAtOffset:tmpHandle.offsetInFile + sizeof(uint32_t)];
            
            struct segment_command * command;
            
            command = malloc(sizeof(struct segment_command));
            [tmpHandle getBytes:command inRange:NSMakeRange(tmpHandle.offsetInFile, sizeof(struct segment_command))];
            
            if (((cmd == LC_SEGMENT) || (cmd == LC_SEGMENT_64)) && (strcmp(command->segname, "__RESTRICT") == 0)) {
                _hasRestrictedSegment = YES;
                break;
            } else{
                [tmpHandle seekToFileOffset:tmpHandle.offsetInFile + size];
            }
            free(command);
        }
        [tmpHandle closeFile];
    }
    return self;
}

-(NSString *)binaryPath{
    NSString *path = [[_bundle executablePath] copy];
    if ([path hasPrefix:@"/var/mobile"]) {
        path = [@"/private" stringByAppendingString:path];
    }
    return path;
}


@end
