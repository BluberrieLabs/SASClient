// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> Any
}

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}

extension ErrorResponse: LocalizedError {
    public var errorDescription: String? {
        switch (self) {
        case .Error( _, _, let error):
            return error.localizedDescription
        }
    }
    public var code: Int {
        switch (self) {
        case .Error( let cde, _, _):
            return cde
        }
    }
}


open class Response<T> {
    open let statusCode: Int
    open let header: [String: String]
    open let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = Int()
class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as AnyObject }
    }

    static func decode<T>(clazz: T.Type, discriminator: String, source: AnyObject) -> T {
        let key = discriminator;
        if let decoder = decoders[key] {
            return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.int32Value as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.int64Value as! T;
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd HH:mm:ss"
        ].map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject) -> Date in
           if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int64 {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        } 

        // Decoder for [ErrorData]
        Decoders.addDecoder(clazz: [ErrorData].self) { (source: AnyObject) -> [ErrorData] in
            return Decoders.decode(clazz: [ErrorData].self, source: source)
        }
        // Decoder for ErrorData
        Decoders.addDecoder(clazz: ErrorData.self) { (source: AnyObject) -> ErrorData in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = ErrorData()
            instance.error = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["error"] as AnyObject?)
            return instance
        }
 

        // Decoder for [FBToken]
        Decoders.addDecoder(clazz: [FBToken].self) { (source: AnyObject) -> [FBToken] in
            return Decoders.decode(clazz: [FBToken].self, source: source)
        }
        // Decoder for FBToken
        Decoders.addDecoder(clazz: FBToken.self) { (source: AnyObject) -> FBToken in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = FBToken()
            instance.fbtoken = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["fbtoken"] as AnyObject?)
            return instance
        }


        // Decoder for [LoginData]
        Decoders.addDecoder(clazz: [LoginData].self) { (source: AnyObject) -> [LoginData] in
            return Decoders.decode(clazz: [LoginData].self, source: source)
        }
        // Decoder for LoginData
        Decoders.addDecoder(clazz: LoginData.self) { (source: AnyObject) -> LoginData in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = LoginData()
            instance.email = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email"] as AnyObject?)
            instance.password = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["password"] as AnyObject?)
            instance.name = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["name"] as AnyObject?)
            return instance
        }


        // Decoder for [MessageData]
        Decoders.addDecoder(clazz: [MessageData].self) { (source: AnyObject) -> [MessageData] in
            return Decoders.decode(clazz: [MessageData].self, source: source)
        }
        // Decoder for MessageData
        Decoders.addDecoder(clazz: MessageData.self) { (source: AnyObject) -> MessageData in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = MessageData()
            instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"] as AnyObject?)
            return instance
        }


        // Decoder for [SimpleEmail]
        Decoders.addDecoder(clazz: [SimpleEmail].self) { (source: AnyObject) -> [SimpleEmail] in
            return Decoders.decode(clazz: [SimpleEmail].self, source: source)
        }
        // Decoder for SimpleEmail
        Decoders.addDecoder(clazz: SimpleEmail.self) { (source: AnyObject) -> SimpleEmail in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = SimpleEmail()
            instance.triggerTag = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["triggerTag"] as AnyObject?)
            instance.sender = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["sender"] as AnyObject?)
            instance.subject = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["subject"] as AnyObject?)
            instance.personal = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["personal"] as AnyObject?)
            instance.body = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["body"] as AnyObject?)
            return instance
        }


        // Decoder for [TokenData]
        Decoders.addDecoder(clazz: [TokenData].self) { (source: AnyObject) -> [TokenData] in
            return Decoders.decode(clazz: [TokenData].self, source: source)
        }
        // Decoder for TokenData
        Decoders.addDecoder(clazz: TokenData.self) { (source: AnyObject) -> TokenData in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = TokenData()
            instance.token = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["token"] as AnyObject?)
            instance.refreshToken = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["refreshToken"] as AnyObject?)
            return instance
        }


        // Decoder for [TotalData]
        Decoders.addDecoder(clazz: [TotalData].self) { (source: AnyObject) -> [TotalData] in
            return Decoders.decode(clazz: [TotalData].self, source: source)
        }
        // Decoder for TotalData
        Decoders.addDecoder(clazz: TotalData.self) { (source: AnyObject) -> TotalData in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = TotalData()
            instance.total = Decoders.decodeOptional(clazz: Int64.self, source: sourceDictionary["total"] as AnyObject?)
            return instance
        }


        // Decoder for [TriggerData]
        Decoders.addDecoder(clazz: [TriggerData].self) { (source: AnyObject) -> [TriggerData] in
            return Decoders.decode(clazz: [TriggerData].self, source: source)
        }
        // Decoder for TriggerData
        Decoders.addDecoder(clazz: TriggerData.self) { (source: AnyObject) -> TriggerData in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = TriggerData()
            instance.triggerTag = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["triggerTag"] as AnyObject?)
            return instance
        }


        // Decoder for [UserData]
        Decoders.addDecoder(clazz: [UserData].self) { (source: AnyObject) -> [UserData] in
            return Decoders.decode(clazz: [UserData].self, source: source)
        }
        // Decoder for UserData
        Decoders.addDecoder(clazz: UserData.self) { (source: AnyObject) -> UserData in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = UserData()
            instance.created = Decoders.decodeOptional(clazz: Date.self, source: sourceDictionary["created"] as AnyObject?)
            instance.last = Decoders.decodeOptional(clazz: Date.self, source: sourceDictionary["last"] as AnyObject?)
            instance.userid = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["userid"] as AnyObject?)
            instance.fullname = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["fullname"] as AnyObject?)
            instance.role = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["role"] as AnyObject?)
            instance.email = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email"] as AnyObject?)
            instance.locked = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["locked"] as AnyObject?)
            instance.closed = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["closed"] as AnyObject?)
            instance.confirmed = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["confirmed"] as AnyObject?)
            instance.facebook = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["facebook"] as AnyObject?)
            return instance
        }
    }()

    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}