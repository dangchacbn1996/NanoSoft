//
//  BaseService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import Alamofire
import Whisper

class BaseService: BaseServiceManager {
    //    var limit = 20
    //    var offset = 0
    
    //    var page = 1
    //    var pageLimit = 5
    //    var per_page = 20
    
    /// Number of items of latest server request.
    var numberOfItemsReceived = 0
    
    var pendingRequest = false
    
    let reachabilityManager = NetworkReachabilityManager()
    
    override init() {
        super.init()
        let domain = Common.HOST
        
        _ = self.initWith(baseURL: domain)
        
        // let user = Session.shared.getUser()
        self.updateHeaderIfNeed(key: Headers.Authorization, value: ConstantsVal.authToken)
        self.updateHeaderIfNeed(key: Headers.Content_Type, value: Headers.Application_json)
        self.updateHeaderIfNeed(key: "Device-Id", value:  ConstantsVal.deviceToken)
        //        self.updateHeaderIfNeed(key: "Device-Id", value:"iOS Tesst 03")
    }

    func logInfoApi(pathURL: String, dataResponse:AFDataResponse<Data>, params: [String : Any]) {
        if let data = dataResponse.data, let utf8Text = String(data: data, encoding: .utf8), let code = dataResponse.response?.statusCode {
            print("-------------START----------")
            print("[URL]: \(self.baseURLAppend(path: pathURL))")
            print("[HeaderInfo]: \(self.headers)")
            print("[Code]: \(code)")
            print("[Request]: \(params.json)")
//            print("Time Request: \(dataResponse.metrics?.transactionMetrics.debugDescription)")
            print("[ResponseJson]: \(utf8Text.description)")
            print("------------END-------------")
            print("")

//            let userInfo: [String:Any] = ["URL":self.baseURLAppend(path: pathURL),"HeaderInfo":self.headers, "Code": code,"Request":params.json,"TimeRequest":dataResponse.timeline.totalDuration,"ResponseJson":utf8Text.description]
//            Logger.shared.info("API INFORMATION", userInfo: userInfo)
        }
    }

    func requestGET<T>(type: T.Type?, params: [String : Any], pathURL: String, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        let dataRequest = sessionManager.request(baseURLAppend(path: pathURL), method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
        dataRequest.responseData { (dataResponse) in

            self.logInfoApi(pathURL: pathURL, dataResponse: dataResponse, params: params)

            self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                if code == NSURLErrorTimedOut  || code == NSURLErrorCannotConnectToHost{
                    self.loadingNoNetwork()
                    return
                }
                if code == 403 {
                    self.forceLogout()
                    return
                }
                if status == false {
                    complete(data, status, code)
                    return
                }
                if let type = type {
                    // parser data to json.
                    self.paserJsonFromData(type: type, from: data as! Data, complete: { (responseJson,status) in
                        if status == true {
                            print("RequestGET_Success_ResponseJson")
                            print(responseJson)
                            complete(responseJson, true, code)
                            
                        } else {
                            self.paserJsonFromData(type: ErrorResponse.self, from: data as! Data, complete: { (responseJson,status) in
                                print("RequestGET_Error_ResponseJson")
                                print(responseJson)
                                complete(responseJson, false, code)
                            })
                        }
                    })
                } else {
                    // model mapping is nil -> return response data
                    complete(data, status, code)
                    return
                }
            })
        }
    }
    
    func requestGET<T>(type: T.Type?, params: [String : Any], pathURL: UrlString, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        let dataRequest = sessionManager.request(baseURLAppend(path: pathURL.rawValue), method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
        dataRequest.responseData { (dataResponse) in

            self.logInfoApi(pathURL: pathURL.rawValue, dataResponse: dataResponse, params: params)

            self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                if code == NSURLErrorTimedOut  || code == NSURLErrorCannotConnectToHost{
                    self.loadingNoNetwork()
                    return
                }
                if code == 403 {
                    self.forceLogout()
                    return
                }
                if status == false {
                    complete(data, status, code)
                    return
                }
                if let type = type {
                    // parser data to json.
                    self.paserJsonFromData(type: type, from: data as! Data, complete: { (responseJson,status) in
                        if status == true {
                            complete(responseJson, true, code)
                            
                        } else {
                            self.paserJsonFromData(type: ErrorResponse.self, from: data as! Data, complete: { (responseJson,status) in
                                complete(responseJson, false, code)
                            })
                        }
                    })
                } else {
                    // model mapping is nil -> return response data
                    complete(data, status, code)
                    return
                }
            })
        }
    }
    
    func requestPOST<T>(type: T.Type?, params: [String : Any], pathURL: UrlString, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        let dataRequest = sessionManager.request(baseURLAppend(path: pathURL.rawValue), method: .post, parameters: params, encoding:  JSONEncoding.default, headers: headers)
        dataRequest.responseData { (dataResponse) in
            self.logInfoApi(pathURL: pathURL.rawValue, dataResponse: dataResponse, params: params)

            self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                if code == NSURLErrorTimedOut  || code == NSURLErrorCannotConnectToHost{
                    self.loadingNoNetwork()
                    return
                }
                if code == 403 {
                    self.forceLogout()
                    return
                }
                if status == false {
                    complete(data, status, code)
                    return
                }
                if let type = type {
                    // parser data to json.
                    self.paserJsonFromData(type: type, from: data as! Data, complete: { (responseJson,status) in
                        if status == true {
                            complete(responseJson, true, code)
                            
                        } else {
                            self.paserJsonFromData(type: ErrorResponse.self, from: data as! Data, complete: { (responseJson,status) in

                                complete(responseJson, false, code)
                            })
                        }
                    })
                } else {
                    // model mapping is nil -> return response data
                    complete(data, status, code)
                    return
                }
            })
        }
    }
    
    func requestDELETE<T>(type: T.Type?, params: [String : Any], pathURL: UrlString, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        let dataRequest = sessionManager.request(baseURLAppend(path: pathURL.rawValue), method: .delete, parameters: params, encoding: URLEncoding.default, headers: headers)
        dataRequest.responseData { (dataResponse) in
            self.logInfoApi(pathURL: pathURL.rawValue, dataResponse: dataResponse, params: params)

            self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                if code == NSURLErrorTimedOut  || code == NSURLErrorCannotConnectToHost{
                    self.loadingNoNetwork()
                    return
                }
                if code == 403 {
                    self.forceLogout()
                    return
                }
                if status == false {
                    complete(data, status, code)
                    return
                }
                if let type = type {
                    // parser data to json.
                    self.paserJsonFromData(type: type, from: data as! Data, complete: { (responseJson,status) in
                        if status == true {
                            complete(responseJson, true, code)
                            
                        } else {
                            self.paserJsonFromData(type: ErrorResponse.self, from: data as! Data, complete: { (responseJson,status) in
                                complete(responseJson, false, code)
                            })
                        }
                    })
                } else {
                    // model mapping is nil -> return response data
                    complete(data, status, code)
                    return
                }
            })
        }
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension BaseService {
    func showSuccess(message: String = "Đã cập nhật") {
        DispatchQueue.main.async {
            Loading.whisper(title: message.localized)
        }
    }
    func showErrorString(title: String = "Common.OK".localized,text: String,action: @escaping (() -> Void)) {
        let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: text.uppercasedFirst, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: title, style: .default, action: action))
        
        UIApplication.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    func showError(response: AnyObject) {
        guard let model = response as? ErrorResponse else {
            return
        }

        let message = model.msg ?? ""
        let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: message, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "Common.OK".localized, style: .default, action: { () -> Void in
            print("Cancel")
        }))
        UIApplication.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    
    /// Check if there are more data from server
    func canLoadMore() -> Bool {
        if pendingRequest { return false }
        
        return numberOfItemsReceived >= 10
    }
    
    func loadingNoNetwork() {
        Loading.whisper(title: "", subtitle: "Không thể kết nối máy chủ.")
    }
    
    func forceLogout() {
        Loading.stopAnimation()
        self.showErrorString(text: "Hết phiên đăng nhập") {
            self.goToSpash()
        }
    }
    
    func goToSpash() {
        UserDefaults.standard.removeObject(forKey: "SignInRequest")
        UserDefaults.standard.removeObject(forKey: "CustomerProfileOptionalResponse")
        guard let rootVC = UIStoryboard.init(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: rootVC)

        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func handleArrayStatus<ModelOptionalResponse: Codable>(modelOptionalResponse: [ModelOptionalResponse].Type,response: AnyObject?, _ status: Bool, _ code: Int?, successBlock: @escaping (_ model: ModelBaseService<[ModelOptionalResponse]>) -> Void, failureBlock: @escaping (_ model: ModelBaseService<[ModelOptionalResponse]>) -> Void, isShowErrorMessage: Bool = true) {
        if status == true {
            if let repo = response as? ModelBaseService<[ModelOptionalResponse]> {
                if repo.code == 1 {
                    successBlock(repo)
                    Loading.stopAnimation()
                } else {
                    self.showErrorString(text: repo.msg ?? "", action: {
                        if repo.code == -15 {
                            self.goToSpash()
                        }
                    })
                    failureBlock(repo)
                    Loading.stopAnimation()
                }
            } else {
                if isShowErrorMessage == true {
                    self.showErrorString(text: "Không xử lý được dữ liệu trả về") {

                    }
                }
                Loading.stopAnimation()
            }
        } else {
            if isShowErrorMessage == true {
                self.showError(response: response as AnyObject)
            }
            Loading.stopAnimation()
        }
    }
    
    func handleObjectStatus<ModelOptionalResponse: Codable>(modelOptionalResponse: ModelOptionalResponse.Type,response: AnyObject?, _ status: Bool, _ code: Int?, successBlock: @escaping (_ model: ModelBaseService<ModelOptionalResponse>) -> Void, failureBlock: @escaping (_ model: ModelBaseService<ModelOptionalResponse>) -> Void) {
        if status == true {
            if let repo = response as? ModelBaseService<ModelOptionalResponse> {
                if repo.code == 1 {
                    successBlock(repo)
                } else {
                    self.showErrorString(text: repo.msg ?? "", action: {
                        if repo.code == -15 {
                            self.goToSpash()
                        }
                    })
                    failureBlock(repo)
                }
            } else {
                self.showErrorString(text: "Không xử lý được dữ liệu trả về") {

                }
                Loading.stopAnimation()
            }
        } else {
            self.showError(response: response as AnyObject)
            Loading.stopAnimation()
        }
    }
}

enum NSURLError: Int {
    case unknown = -1
    case cancelled = -999
    case badURL = -1000
    case timedOut = -1001
    case unsupportedURL = -1002
    case cannotFindHost = -1003
    case cannotConnectToHost = -1004
    case connectionLost = -1005
    case lookupFailed = -1006
    case HTTPTooManyRedirects = -1007
    case resourceUnavailable = -1008
    case notConnectedToInternet = -1009
    case redirectToNonExistentLocation = -1010
    case badServerResponse = -1011
    case userCancelledAuthentication = -1012
    case userAuthenticationRequired = -1013
    case zeroByteResource = -1014
    case cannotDecodeRawData = -1015
    case cannotDecodeContentData = -1016
    case cannotParseResponse = -1017
    //case NSURLErrorAppTransportSecurityRequiresSecureConnection NS_ENUM_AVAILABLE(10_11, 9_0) = -1022
    case fileDoesNotExist = -1100
    case fileIsDirectory = -1101
    case noPermissionsToReadFile = -1102
    //case NSURLErrorDataLengthExceedsMaximum NS_ENUM_AVAILABLE(10_5, 2_0) =   -1103
    
    // SSL errors
    case secureConnectionFailed = -1200
    case serverCertificateHasBadDate = -1201
    case serverCertificateUntrusted = -1202
    case serverCertificateHasUnknownRoot = -1203
    case serverCertificateNotYetValid = -1204
    case clientCertificateRejected = -1205
    case clientCertificateRequired = -1206
    case cannotLoadFromNetwork = -2000
    
    // Download and file I/O errors
    case cannotCreateFile = -3000
    case cannotOpenFile = -3001
    case cannotCloseFile = -3002
    case cannotWriteToFile = -3003
    case cannotRemoveFile = -3004
    case cannotMoveFile = -3005
    case downloadDecodingFailedMidStream = -3006
    case downloadDecodingFailedToComplete = -3007
    
    /*
     case NSURLErrorInternationalRoamingOff NS_ENUM_AVAILABLE(10_7, 3_0) =         -1018
     case NSURLErrorCallIsActive NS_ENUM_AVAILABLE(10_7, 3_0) =                    -1019
     case NSURLErrorDataNotAllowed NS_ENUM_AVAILABLE(10_7, 3_0) =                  -1020
     case NSURLErrorRequestBodyStreamExhausted NS_ENUM_AVAILABLE(10_7, 3_0) =      -1021
     
     case NSURLErrorBackgroundSessionRequiresSharedContainer NS_ENUM_AVAILABLE(10_10, 8_0) = -995
     case NSURLErrorBackgroundSessionInUseByAnotherProcess NS_ENUM_AVAILABLE(10_10, 8_0) = -996
     case NSURLErrorBackgroundSessionWasDisconnected NS_ENUM_AVAILABLE(10_10, 8_0)= -997
     */
}
