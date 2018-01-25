//
//  NetworkTool.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
import Alamofire
enum requestMethod : Int{
    case GET = 0
    case POST = 1
}

typealias NetworkCompletion = (_ responseJSON: [String: AnyObject]?, _ error: Error?) ->()
// 从请求到的根字典取到想要的数组
class NetworkTool {
    
    private init(){
        
    }

    class func request(url: String, method: requestMethod , parameters:[String: Any]?, headers:HTTPHeaders = [:] ,completion:  @escaping NetworkCompletion){
        let getOrPost = method.rawValue
        
        /// 需要重构 请求的回调. 不再用 completion(包含两个可为nil对象)
        Alamofire.request(url, method: getOrPost == 0 ? .get : .post, parameters: parameters, headers: headers).responseJSON { responseJSON in
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
enum RequestError: Error {
    case serviceLost
    case timeout
    case emptyData
}
enum Result<A, RequestError> {
    case failture(RequestError)
    case success(A)
}




//MARK:- 具体请求
extension NetworkTool {
    /// 加载首页推荐数据
   class func loadHomeRecommand(_ completion:@escaping NetworkCompletion) {
        let urlString = kBaseUrl + "feed/v1/recommend/classic"
        let parameters = ["device": "iphone",
                          "pageId": "1",
                          "pageSize": "20",
                          "ts": "1471058513.913570",
                          "tsuid": "43342908"]
        let headers = ["User-Agent": "ting_v5.4.39_c5(CFNetwork, iPhone OS 10.0.1,iPhone8,1)",
                       "Cookie": "domain=.ximalaya.com; path=/; channel=ios-b1; 1&_device=iPhone&5C60B916-A283-4DD3-98B1-8C42A8A889CF&5.4.39; impl=com.gemd.iting; NSUP=42E2BCFA%2C41B9139F%2C1477444624265; XUM=5C60B916-A283-4DD3-98B1-8C42A8A889CF; c-oper=%E6%9C%AA%E7%9F%A5; net-mode=WIFI; res=750%2C1334; idfa=5C60B916-A283-4DD3-98B1-8C42A8A889CF"]
        request(url: urlString, method: .GET, parameters: parameters, headers: headers, completion: completion)
    }
    
    
}






