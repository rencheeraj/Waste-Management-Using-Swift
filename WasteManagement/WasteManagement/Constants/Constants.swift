//
//  Constants.swift
//  WasteManagement
//
//  Created by Rencheeraj Mohan on 02/06/23.
//

import Foundation

let base_url = "http://test.aakri.in/api/home/list"
let authData = "YWRtaW46MTIzNA=="
let basicAuthValue = "Basic "
let BASIC_AUTH = basicAuthValue+authData
let params = "city=1"
let SESSION_VALUE = "8WK4WCO4"

enum HeaderField : String{
    case authentication = "Authorization"
    case acceptType = "Accept"
    case session = "session"
    case content_type = "Content-Type"
    case post = "POST"
}
enum ContentType : String{
    case json = "application/x-www-form-urlencoded"
}
