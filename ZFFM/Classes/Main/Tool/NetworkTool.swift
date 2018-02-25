//
//  NetworkTool.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
import Alamofire
enum RequestMethod : Int{
    case GET
    case POST
}
enum RequestError: Error {
    case serviceLost
    case timeout
    case emptyData
}
//extension Result<Value> {
//    static func ??<T>(result: Result<T>) -> T {
//        
//    }
//}
extension Resource {
    
}
/// 请求数据所用资源
struct Resource<Models> {
    let requestUrl: String
    let requestParam: [String: Any]
    let method: RequestMethod = .GET
    let headers: HTTPHeaders = [:]
    let parse: ([String: AnyObject]) -> Models?
    
    func requestData(_ callBack: @escaping (Models?) -> ()) {
        
        NetworkTool.request(resource: self) { (result) in
            let a = result
            
            guard let rootDict = result.value as? [String: AnyObject] else {// 字典无值
                print(result.error)
                return
            }
            callBack(self.parse(rootDict))
        }
    }
    
    func jsonArr<A>(_ transform: @escaping (Any) -> (A?)) -> (Any) -> [A]? {

        return { array in
            guard let array = array as? [Any] else {return nil}
            return array.flatMap(transform)
        }
    }
}

typealias NetworkCompletion = (_ rootDict: [String:AnyObject]?, _ error: Error?) -> ()
// 从请求到的根字典取到想要的数组
class NetworkTool {
    
    private init(){
        
    }
    class func request<A>(resource: Resource<A>, _ callBack: @escaping (Result<Any>) -> ()) {
        
        Alamofire.request(resource.requestUrl, method: resource.method == .GET ? .get : .post, parameters: resource.requestParam, headers: resource.headers).responseJSON { (responseJSON) in
            let result = responseJSON.result
            callBack(result)
        }
    }
    
    
    class func request(url: String, method: RequestMethod , parameters:[String: Any]?, headers:HTTPHeaders = [:] ,completion:  @escaping NetworkCompletion){
        
        /// 需要重构 请求的回调. 不再用 completion(包含两个可为nil对象)
        Alamofire.request(url, method: method == .GET ? .get : .post, parameters: parameters, headers: headers).responseJSON { responseJSON in
            let result = responseJSON.result
            // result 枚举中有 存JSON的result.value 和 成功与否的error/isSuccess
            
            guard let resultDict = result.value else {
                
                completion(nil, result.error)
                return
            }
            completion(resultDict as? [String : AnyObject], result.error)
        }

    }
}





