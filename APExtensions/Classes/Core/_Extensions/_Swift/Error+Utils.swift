//
//  Error+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/28/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import CFNetwork
import Foundation

public extension Error {
    
    /// Returns `self` as `NSError`
    var asNSError: NSError {
        self as NSError
    }
    
    /// Checks if cancelled error
    var isCancelledError: Bool {
        guard _domain == NSURLErrorDomain else { return false }
        return _code == NSURLErrorCancelled
    }
    
    /// Checks if error is related to connection problems. Usual flow is to retry on those errors.
    var isConnectionError: Bool {
        Self.isConnectionError(self)
    }
    
    var coreErrorCode: Int {
        coreError._code
    }
    
    /// Gets the first error from underlying or `self` and casts it to `NSError`
    var coreNSError: NSError {
        coreError as NSError
    }
    
    /// Gets the first error from underlying or `self`
    var coreError: Error {
        var coreError: Error = self
        while let underlyingError = coreError.underlyingError {
            coreError = underlyingError
        }
        
        return coreError
    }
    
    /// Example: `SKErrorDomain 0 | ASDErrorDomain 500 | AMSErrorDomain 305`
    var segmentationString: String {
        var segmentationStringComponents: [String] = ["\(_domain) \(_code)"]
        var coreError: Error = self
        while let underlyingError = coreError.underlyingError {
            coreError = underlyingError
            segmentationStringComponents.append("\(underlyingError._domain) \(underlyingError._code)")
        }
        
        return segmentationStringComponents.joined(separator: " | ")
    }
    
    var underlyingNSError: NSError? {
        userInfo?[NSUnderlyingErrorKey] as? NSError
    }
    
    var underlyingError: Error? {
        userInfo?[NSUnderlyingErrorKey] as? Error
    }
    
    @available(iOS 14.5, *)
    var underlyingErrors: [Error]? {
        userInfo?[NSMultipleUnderlyingErrorsKey] as? [Error]
    }
    
    var userInfo: [AnyHashable: Any]? {
        _userInfo as? [AnyHashable: Any]
    }
}

public extension Error? {
    
    /// Example: `SKErrorDomain 0 | ASDErrorDomain 500 | AMSErrorDomain 305`
    var segmentationString: String {
        switch self {
        case .none: "nil"
        case .some(let error): error.segmentationString
        }
    }
}

// ******************************* MARK: - Static

fileprivate let kCFErrorDomainCFNetworkString = kCFErrorDomainCFNetwork.asString

public extension Error {
    
    /// Checks if error is related to connection problems. Usual flow is to retry on those errors.
    ///
    static func isConnectionError(_ error: Error?) -> Bool {
        guard let error else { return false }
        
        switch error._domain {
        case NSURLErrorDomain:
            switch error._code {
                // Error Type=AFError sessionTaskFailed(error: Error Domain=NSURLErrorDomain Code=-1000 "bad URL" UserInfo={_kCFStreamErrorCodeKey=22, NSUnderlyingError=0x2820e6820 {Error Domain=kCFErrorDomainCFNetwork Code=-1000 "(null)" UserInfo={_NSURLErrorNWPathKey=satisfied (Path is satisfied), interface: en0[802.11], ipv4, dns, proxy, _kCFStreamErrorCodeKey=22, _kCFStreamErrorDomainKey=1}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <8EBEF50F-CBA4-4518-B552-ED61B4274A46>.<62>, _NSURLErrorRelatedURLSessionTaskErrorKey=("LocalDataTask <8EBEF50F-CBA4-4518-B552-ED61B4274A46>.<62>"), NSLocalizedDescription=bad URL, NSErrorFailingURLStringKey=https://google.com, NSErrorFailingURLKey=https://google.com, _kCFStreamErrorDomainKey=1})
                // It looks like it may fail if the app is suspended and then resumed because the URL looks fine
            case NSURLErrorBadURL: return true
                
                // Sometimes happens. Probably because of DNS issue.
            case NSURLErrorCannotFindHost: return true
                
                // Error Domain=NSURLErrorDomain Code=-1017 "cannot parse response" UserInfo={_kCFStreamErrorCodeKey=-1, NSunderlying=0x280b83120 {Error Domain=kCFErrorDomainCFNetwork Code=-1017 "(null)" UserInfo={NSErrorPeerAddressKey=<CFData 0x2826f5130 [0x1f994c660]>{length = 16, capacity = 16, bytes = 0x100201bb340a0cb20000000000000000}, _kCFStreamErrorCodeKey=-1, _kCFStreamErrorDomainKey=4}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <5AFF9FCB-2311-4458-B938-C121873305C7>.<65>, _NSURLErrorRelatedURLSessionTaskErrorKey=( "LocalDataTask <5AFF9FCB-2311-4458-B938-C121873305C7>.<65>" ), NSLocalizedDescription=cannot parse response, NSErrorFailingURLStringKey=https://google.com, NSErrorFailingURLKey=https://google.com, _kCFStreamErrorDomainKey=4}
            case NSURLErrorCannotParseResponse: return true
                
                // NSURLErrorDomain -1009 | kCFErrorDomainCFNetwork -1009
                // Error Domain=NSURLErrorDomain Code=-1009 "The Internet connection appears to be offline." UserInfo={_kCFStreamErrorCodeKey=50, NSUnderlyingError=0x106a29cb0 {Error Domain=kCFErrorDomainCFNetwork Code=-1009 "(null)" UserInfo={_kCFStreamErrorDomainKey=1, _kCFStreamErrorCodeKey=50, _NSURLErrorNWResolutionReportKey=Resolved 0 endpoints in 1ms using unknown from cache, _NSURLErrorNWPathKey=unsatisfied (Denied over Wi-Fi interface), interface: en0[802.11], ipv4, dns, uses wifi, LQM: good}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <93FD5AD0-5D80-4BBB-8095-4970F095535D>.<1>, _NSURLErrorRelatedURLSessionTaskErrorKey=(\n "LocalDataTask <93FD5AD0-5D80-4BBB-8095-4970F095535D>.<1>"\n), NSLocalizedDescription=The Internet connection appears to be offline., NSErrorFailingURLStringKey=https://api.divtools.com/version, NSErrorFailingURLKey=https://api.divtools.com/version, _kCFStreamErrorDomainKey=1}
            case NSURLErrorNotConnectedToInternet: return true
                
            case NSURLErrorCannotConnectToHost: return true
            case NSURLErrorInternationalRoamingOff: return true
                
                // NSURLErrorDomain -1005 | kCFErrorDomainCFNetwork -1005
                // Error Domain=NSURLErrorDomain Code=-1005 \"The network connection was lost.\" UserInfo={_kCFStreamErrorCodeKey=53, NSUnderlyingError=0x281265a70 {Error Domain=kCFErrorDomainCFNetwork Code=-1005 \"(null)\" UserInfo={_kCFStreamErrorCodeKey=53, _kCFStreamErrorDomainKey=1}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <CA83E4A8-9EAC-4B4F-AAD7-BB0E3B2B79CA>.<37>, _NSURLErrorRelatedURLSessionTaskErrorKey=(\n    \"LocalDataTask <CA83E4A8-9EAC-4B4F-AAD7-BB0E3B2B79CA>.<37>\"\n), NSLocalizedDescription=The network connection was lost., NSErrorFailingURLStringKey=https://google.com, NSErrorFailingURLKey=https://google.com, _kCFStreamErrorDomainKey=1}
            case NSURLErrorNetworkConnectionLost: return true
                
            case NSURLErrorDNSLookupFailed: return true
            case NSURLErrorTimedOut: return true
                
                // Error Domain=NSURLErrorDomain Code=-1019 "A data connection cannot be established since a call is currently active." UserInfo={_kCFStreamErrorCodeKey=50, NSunderlying=0x281f84c30 {Error Domain=kCFErrorDomainCFNetwork Code=-1019 "(null)" UserInfo={_kCFStreamErrorCodeKey=50, _kCFStreamErrorDomainKey=1}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <51078FEF-61AB-42B2-B480-2C14BA8A74E4>.<74>, _NSURLErrorRelatedURLSessionTaskErrorKey=( "LocalDataTask <51078FEF-61AB-42B2-B480-2C14BA8A74E4>.<74>" ), NSLocalizedDescription=A data connection cannot be established since a call is currently active., NSErrorFailingURLStringKey=https://google.com, NSErrorFailingURLKey=https://google.com, _kCFStreamErrorDomainKey=1}
            case NSURLErrorCallIsActive: return true
                
                // Error Domain=NSURLErrorDomain Code=-1020 "A data connection is not currently allowed." UserInfo={_kCFStreamErrorCodeKey=50, NSunderlying=0x282b0fe40 {Error Domain=kCFErrorDomainCFNetwork Code=-1020 "(null)" UserInfo={_kCFStreamErrorCodeKey=50, _kCFStreamErrorDomainKey=1}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <6DC6A5A9-AAD6-486F-BA2D-75FD91B3723B>.<68>, _NSURLErrorRelatedURLSessionTaskErrorKey=( "LocalDataTask <6DC6A5A9-AAD6-486F-BA2D-75FD91B3723B>.<68>" ), NSLocalizedDescription=A data connection is not currently allowed., NSErrorFailingURLStringKey=https://google.com, NSErrorFailingURLKey=https://google.com, _kCFStreamErrorDomainKey=1}
            case NSURLErrorDataNotAllowed: return true
                
                // NSURLErrorDomain -1200 | kCFErrorDomainCFNetwork -1200
                // Error Domain=NSURLErrorDomain Code=-1200 "An SSL error has occurred and a secure connection to the server cannot be made." UserInfo={NSErrorFailingURLStringKey=https://google.com, NSLocalizedRecoverySuggestion=Would you like to connect to the server anyway?, _kCFStreamErrorDomainKey=3, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <70BBAD78-673F-4A57-8CAE-F5C1426B0347>.<170>, _NSURLErrorRelatedURLSessionTaskErrorKey=( "LocalDataTask <70BBAD78-673F-4A57-8CAE-F5C1426B0347>.<170>" ), NSLocalizedDescription=An SSL error has occurred and a secure connection to the server cannot be made., NSErrorFailingURLKey=https://google.com, NSunderlying=0x282ade400 {Error Domain=kCFErrorDomainCFNetwork Code=-1200 "(null)" UserInfo={_kCFStreamPropertySSLClientCertificateState=0, _kCFNetworkCFStreamSSLErrorOriginalValue=-9816, _kCFStreamErrorDomainKey=3, _kCFStreamErrorCodeKey=-9816}}, _kCFStreamErrorCodeKey=-9816}
                // This might happen while we connect to a public Wi-Fi and not yet logged in so we can retry that
            case NSURLErrorSecureConnectionFailed: return true
                
                // Error Domain=NSURLErrorDomain Code=-1202 "The certificate for this server is invalid. You might be connecting to a server that is pretending to be “google.com” which could put your confidential information at risk." UserInfo={NSLocalizedRecoverySuggestion=Would you like to connect to the server anyway?, _kCFStreamErrorDomainKey=3, NSErrorPeerCertificateChainKey=( "<cert(0x109817600) s: secure-login.attwifi.com i: ATT Atlas R3 OV TLS CA 2020>", "<cert(0x109844600) s: ATT Atlas R3 OV TLS CA 2020 i: GlobalSign>", "<cert(0x109818600) s: GlobalSign i: GlobalSign>" ), NSErrorClientCertificateStateKey=0, NSErrorFailingURLKey=https://google.com, NSErrorFailingURLStringKey=https://google.com, NSunderlying=0x280753ed0 {Error Domain=kCFErrorDomainCFNetwork Code=-1202 "(null)" UserInfo={_kCFStreamPropertySSLClientCertificateState=0, kCFStreamPropertySSLPeerTrust=<SecTrustRef: 0x283b44f30>, _kCFNetworkCFStreamSSLErrorOriginalValue=-9843, _kCFStreamErrorDomainKey=3, _kCFStreamErrorCodeKey=-9843, kCFStreamPropertySSLPeerCertificates=( "<cert(0x109817600) s: secure-login.attwifi.com i: ATT Atlas R3 OV TLS CA 2020>", "<cert(0x109844600) s: ATT Atlas R3 OV TLS CA 2020 i: GlobalSign>", "<cert(0x109818600) s: GlobalSign i: GlobalSign>" )}}, _NSURLErrorRelatedURLSessionTaskErrorKey=( "LocalDataTask <EEF469C1-2EEE-4A32-A6B9-FF153B23D401>.<170>" ), _kCFStreamErrorCodeKey=-9843, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <EEF469C1-2EEE-4A32-A6B9-FF153B23D401>.<170>, NSURLErrorFailingURLPeerTrustErrorKey=<SecTrustRef: 0x283b44f30>, NSLocalizedDescription=The certificate for this server is invalid. You might be connecting to a server that is pretending to be “google.com” which could put your confidential information at risk.}
                // Something is wrong with certificate for the ISP that user uses. We should be able to retry that if he switch a Wi-Fi or maybe cell tower.
            case NSURLErrorServerCertificateUntrusted: return true
                
            default: return false
            }
            
        case NSPOSIXErrorDomain:
            switch Int32(error._code) {
                // Error Domain=NSPOSIXErrorDomain Code=2 \"No such file or directory\" UserInfo={_NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <66BA5743-D021-434B-8CAB-DD57436864E5>.<34>, _kCFStreamErrorDomainKey=1, _NSURLErrorRelatedURLSessionTaskErrorKey=(\n \"LocalDataTask <66BA5743-D021-434B-8CAB-DD57436864E5>.<34>\"\n), _kCFStreamErrorCodeKey=2}
                // Probably retryable and related to the app suspend in the background but hard to say
            case ENOENT: return true
                
                // Error Domain=NSPOSIXErrorDomain Code=9 "Bad file descriptor" UserInfo={_NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <EB0526A2-6189-476E-8CC4-A783E2AFDEF5>.<4>, _kCFStreamErrorDomainKey=1, _kCFStreamErrorCodeKey=9, _NSURLErrorRelatedURLSessionTaskErrorKey=(\n "LocalDataTask <EB0526A2-6189-476E-8CC4-A783E2AFDEF5>.<4>"\n), _NSURLErrorNWPathKey=satisfied (Path is satisfied), viable, interface: lo0}
            case EBADF: return true
                
                // Error Domain=NSPOSIXErrorDomain Code=40 "Message too long" UserInfo={_NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <C3FF3897-4612-4A53-B781-88AEEC3EF78B>.<1>, _kCFStreamErrorDomainKey=1, NSErrorPeerAddressKey=<CFData 0x127a5d4a0 [0x1f83044d0]>{length = 16, capacity = 16, bytes = 0x100201bb8fcc7e4e0000000000000000}, _kCFStreamErrorCodeKey=40, _NSURLErrorRelatedURLSessionTaskErrorKey=(\n "LocalDataTask <C3FF3897-4612-4A53-B781-88AEEC3EF78B>.<1>"\n)}
            case EMSGSIZE: return true
                
                // Error Domain=NSPOSIXErrorDomain Code=53 "Software caused connection abort" UserInfo={_NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <5566AF6B-315C-4DB6-AA9B-097726C35449>.<1>, _kCFStreamErrorDomainKey=1, _NSURLErrorRelatedURLSessionTaskErrorKey=( "LocalDataTask <5566AF6B-315C-4DB6-AA9B-097726C35449>.<1>" ), _kCFStreamErrorCodeKey=53}
            case ECONNABORTED: return true
                
                // 64
            case EHOSTDOWN: return true
                
                // 65
            case EHOSTUNREACH: return true
                
                // Error Domain=NSPOSIXErrorDomain Code=100 "Protocol error" UserInfo={_NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <951811DF-2DF4-4C40-9039-7D948877D680>.<4>, _kCFStreamErrorDomainKey=1, NSErrorPeerAddressKey=<CFData 0x2825f4410 [0x1d4213a20]>{length = 16, capacity = 16, bytes = 0x100201bb22da284d0000000000000000}, _kCFStreamErrorCodeKey=100, _NSURLErrorRelatedURLSessionTaskErrorKey=( "LocalDataTask <951811DF-2DF4-4C40-9039-7D948877D680>.<4>" )}
                // Looks retryable
            case EPROTO: return true
                
            default: return false
            }
            
        case kCFErrorDomainCFNetworkString:
            switch Int32(error._code) {
                
                // 1
            case CFNetworkErrors.cfHostErrorHostNotFound.rawValue: return true
                
                // 2
            case CFNetworkErrors.cfHostErrorUnknown.rawValue: return true
                
                // Error Domain=kCFErrorDomainCFNetwork Code=303 "(null)" UserInfo={_NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <1EB7A0AD-0C68-445A-973D-98E4515E4E5A>.<58>, _kCFStreamErrorDomainKey=4, NSErrorPeerAddressKey=<CFData 0x2809a81e0 [0x1e5c1d860]>{length = 16, capacity = 16, bytes = 0x100201bb3647f9f60000000000000000}, _kCFStreamErrorCodeKey=-2201, _NSURLErrorRelatedURLSessionTaskErrorKey=(\n    "LocalDataTask <1EB7A0AD-0C68-445A-973D-98E4515E4E5A>.<58>"\n)}
            case CFNetworkErrors.cfErrorHTTPParseFailure.rawValue: return true
                
                // Proxy connection error is definitely a connection error
                // error: Error Domain=kCFErrorDomainCFNetwork Code=310 "(null)" UserInfo={_NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <89216309-27A7-47C8-A7AB-57D64DA93964>.<170>, _kCFStreamErrorDomainKey=4, _NSURLErrorRelatedURLSessionTaskErrorKey=( "LocalDataTask <89216309-27A7-47C8-A7AB-57D64DA93964>.<170>" ), _kCFStreamErrorCodeKey=-2096}
            case CFNetworkErrors.cfErrorHTTPSProxyConnectionFailure.rawValue: return true
                
                // Probably retriable. At least after we leave the proxy connection.
                // error: Error Domain=kCFErrorDomainCFNetwork Code=311 "(null)" UserInfo={_NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <E00F5A13-F944-4DEB-87B8-5E18BD1D9F0A>.<610>, _kCFStreamErrorDomainKey=4, _NSURLErrorRelatedURLSessionTaskErrorKey=( "LocalDataTask <E00F5A13-F944-4DEB-87B8-5E18BD1D9F0A>.<610>" ), _kCFStreamErrorCodeKey=-2098}
            case CFNetworkErrors.cfStreamErrorHTTPSProxyFailureUnexpectedResponseToCONNECTMethod.rawValue: return true
                
                // Error Domain=kCFErrorDomainCFNetwork Code=-998 "(null)" UserInfo={_kCFStreamErrorCodeKey=0, _kCFStreamErrorDomainKey=2}
                // Let's retry and see
            case CFNetworkErrors.cfurlErrorUnknown.rawValue: return true
                
            default: return false
            }
            
        default: return false
        }
    }
}
