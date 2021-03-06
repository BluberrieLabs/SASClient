//
// UserData.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class UserData: JSONEncodable {
    public var created: Date?
    public var last: Date?
    public var userid: String?
    public var fullname: String?
    public var role: String?
    public var email: String?
    public var locked: Bool?
    public var closed: Bool?
    public var confirmed: Bool?
    public var facebook: Bool?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["created"] = self.created?.encodeToJSON()
        nillableDictionary["last"] = self.last?.encodeToJSON()
        nillableDictionary["userid"] = self.userid
        nillableDictionary["fullname"] = self.fullname
        nillableDictionary["role"] = self.role
        nillableDictionary["email"] = self.email
        nillableDictionary["locked"] = self.locked
        nillableDictionary["closed"] = self.closed
        nillableDictionary["confirmed"] = self.confirmed
        nillableDictionary["facebook"] = self.facebook
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
