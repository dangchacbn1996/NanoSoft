//
//  BaseServiceManager.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import Alamofire

struct Headers {
    static let Content_Type = "Content-Type"
    static let Accept = "Accept"
    static let Authorization = "Authorization"
    static let Application_json = "application/json"
    static let Application_form_urlencoded = "application/x-www-form-urlencoded"
    static let Application_form_data = "application/form-data"
    static let TextHtml = "text/html"
    static let ChildId = "childId"
}

enum FileType {
    case Image
    case Link
}

struct UploadFile {
    // type image or link
    var fileType: FileType
    
    var fileName: String?
    var withName: String?
    var mimeType: String?
    var scale: Float?
    
    //local file to upload
    var pathFile: String?
    // type image to upload
    var image: UIImage?
    
    //full URL upload
    var url: NSURL?
}

struct BodyStringEncoding: ParameterEncoding {
    
    private let body: String
    
    init(body: String) { self.body = body }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard var urlRequest = urlRequest.urlRequest else { throw Errors.emptyURLRequest }
        guard let data = body.data(using: .utf8) else { throw Errors.encodingProblem }
        urlRequest.httpBody = data
        return urlRequest
    }
}

extension BodyStringEncoding {
    enum Errors: Error {
        case emptyURLRequest
        case encodingProblem
    }
}

extension BodyStringEncoding.Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyURLRequest: return "Empty url request"
        case .encodingProblem: return "Encoding problem"
        }
    }
}


class BaseServiceManager  {
    var sessionManager: Session!
    //    var backgroundSessionManager: Session!
    var baseURL: String = ""
    var headers: HTTPHeaders = [:]
    var timeOut = 120
    
    init() {
        sessionConfiguration()
    }
    
    // init with base url
    func initWith(baseURL:String) -> BaseServiceManager {
        self.baseURL = baseURL
        sessionConfiguration()
        return self
    }
    
    func sessionConfiguration() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeOut)
        //        configuration.requestCachePolicy = .returnCacheDataElseLoad
        //        configuration.httpAdditionalHeaders = headers.defaultUserAgent
        sessionManager = Session(configuration: configuration)
        //        sessionManager.adapter = RequestInterceptor()
    }
    
    // MARK:- update headerIfNeed
    func updateHeaderIfNeed(key: String, value: String) -> Void {
        headers.update(name: key, value: value)
    }
    
    func baseURLAppend(path:String) -> String {
        let fullPath = baseURL + path
        return fullPath
    }
    
    func request<T>(type: T.Type?, method: HTTPMethod, params: String, pathURL: String, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        sessionManager.request(baseURLAppend(path: pathURL), method: method, parameters: nil, encoding: BodyStringEncoding(body: params) as ParameterEncoding, headers: headers).responseData { (dataResponse) in
            self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                if status == false {
                    complete(data, status, code)
                    return
                }
                if let type = type {
                    // parser data to json.
                    self.paserJsonFromData(type: type, from: data as! Data, complete: { (responseJson,status) in
                        complete(responseJson, status, code)
                    })
                } else {
                    // model mapping is nil -> return response data
                    complete(data, status, code)
                    return
                }
            })
        }
    }
    
    
    // MARK: Action get, post, delete, upload
    // Model mapping is nil -> return response data type
    func request<T>(type: T.Type?, method: HTTPMethod, params: [String : Any], pathURL: String, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        sessionManager.request(baseURLAppend(path: pathURL), method: method, parameters: params, encoding: URLEncoding.default, headers: headers).responseData { (dataResponse) in
            self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                if status == false {
                    complete(data, status, code)
                    return
                }
                if let type = type {
                    // parser data to json.
                    self.paserJsonFromData(type: type, from: data as! Data, complete: { (responseJson,status) in
                        complete(responseJson, status, code)
                    })
                } else {
                    // model mapping is nil -> return response data
                    complete(data, status, code)
                    return
                }
            })
        }
    }
    
    func request<T>(type: T.Type?, method: HTTPMethod, params: [String : Any], pathURL: String, attachData: [UploadFile], uploadProgress: @escaping (_ progress: Progress) -> Void, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        
        let upload = sessionManager.upload(multipartFormData: { (multipartFormData) in
            for attachFile in attachData {
                if attachFile.fileType == .Image {
                    guard let image = attachFile.image else {return}
                    if let imageData = image.jpegData(compressionQuality: CGFloat(attachFile.scale ?? 1)) {
                        multipartFormData.append(imageData, withName: attachFile.withName ?? "", fileName: attachFile.fileName ?? "" , mimeType: attachFile.mimeType ?? "")
                    }
                } else {
                    guard let pathFile = attachFile.pathFile else {return}
                    do {
                        let imageData = try Data(contentsOf: pathFile.asURL())
                        multipartFormData.append(imageData, withName: attachFile.withName ?? "", fileName: attachFile.fileName ?? "" , mimeType: attachFile.mimeType ?? "")
                    } catch {
                        print ("loading image file error")
                    }
                }
            }
            
            for (key, value) in params {
                let stringValue = "\(value)"
                if stringValue.isEmpty { return }
                
                if let data = stringValue.data(using: String.Encoding.utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: baseURLAppend(path: pathURL), method: method, headers: headers)
        
        upload.uploadProgress(closure: { (progress) in
            uploadProgress(progress)
        })
        upload.responseData(completionHandler: { (dataResponse) in
            self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                if status == false {
                    complete(data, status, code)
                    return
                }
                // model mapping is nil -> return response data
                if type == nil {
                    complete(data, status, code)
                    return
                }
                // parser data to json.
                self.paserJsonFromData(type: type!, from: data as! Data, complete: { (responseJson,status) in
                    complete(responseJson, status, code)
                })
            })
        })
    }
}

extension BaseServiceManager {
    func paserJsonFromData<T>(type: T.Type, from data: Data, complete:@escaping (_ response:AnyObject, _ status:Bool)->Void) where T: Decodable {
        let decoder = JSONDecoder()
        do {
            let parsedData = try decoder.decode(type, from: data)
            complete(parsedData as AnyObject, true)
        } catch {
            print(error)
            complete(error.localizedDescription as AnyObject, false)
        }
    }
    
    func handleResponse(dataResponse:AFDataResponse<Data>, complete:@escaping (_ response:AnyObject, _ status:Bool, _ statusCode: Int)->Void) {
        switch(dataResponse.result) {
        case .success(let value):
            complete(value as AnyObject, true, dataResponse.response?.statusCode ?? -1004)
            break
        case .failure(let error):
            complete(error as AnyObject, false, error._code)
            break
        }
    }
}

extension Dictionary {

    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }

    func printJson() {
        print(json)
    }

}
