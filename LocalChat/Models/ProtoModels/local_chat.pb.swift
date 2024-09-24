// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: local_chat.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
@preconcurrency import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct Request {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: UInt32 = 0

  var idempotencyKey: String = String()

  var payload: Request.OneOf_Payload? = nil

  var sysInit: SysInit {
    get {
      if case .sysInit(let v)? = payload {return v}
      return SysInit()
    }
    set {payload = .sysInit(newValue)}
  }

  var ping: Ping {
    get {
      if case .ping(let v)? = payload {return v}
      return Ping()
    }
    set {payload = .ping(newValue)}
  }

  var checkLogin: CheckLogin {
    get {
      if case .checkLogin(let v)? = payload {return v}
      return CheckLogin()
    }
    set {payload = .checkLogin(newValue)}
  }

  var sendSmsCode: SendSmsCode {
    get {
      if case .sendSmsCode(let v)? = payload {return v}
      return SendSmsCode()
    }
    set {payload = .sendSmsCode(newValue)}
  }

  var sighIn: SighIn {
    get {
      if case .sighIn(let v)? = payload {return v}
      return SighIn()
    }
    set {payload = .sighIn(newValue)}
  }

  var signUp: SighUp {
    get {
      if case .signUp(let v)? = payload {return v}
      return SighUp()
    }
    set {payload = .signUp(newValue)}
  }

  var authorize: Authorize {
    get {
      if case .authorize(let v)? = payload {return v}
      return Authorize()
    }
    set {payload = .authorize(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Payload: Equatable {
    case sysInit(SysInit)
    case ping(Ping)
    case checkLogin(CheckLogin)
    case sendSmsCode(SendSmsCode)
    case sighIn(SighIn)
    case signUp(SighUp)
    case authorize(Authorize)

  #if !swift(>=4.1)
    static func ==(lhs: Request.OneOf_Payload, rhs: Request.OneOf_Payload) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.sysInit, .sysInit): return {
        guard case .sysInit(let l) = lhs, case .sysInit(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.ping, .ping): return {
        guard case .ping(let l) = lhs, case .ping(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.checkLogin, .checkLogin): return {
        guard case .checkLogin(let l) = lhs, case .checkLogin(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.sendSmsCode, .sendSmsCode): return {
        guard case .sendSmsCode(let l) = lhs, case .sendSmsCode(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.sighIn, .sighIn): return {
        guard case .sighIn(let l) = lhs, case .sighIn(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.signUp, .signUp): return {
        guard case .signUp(let l) = lhs, case .signUp(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.authorize, .authorize): return {
        guard case .authorize(let l) = lhs, case .authorize(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  init() {}
}

struct Response {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: UInt32 = 0

  var idempotencyKey: String = String()

  var payload: Response.OneOf_Payload? = nil

  var bool: Bool {
    get {
      if case .bool(let v)? = payload {return v}
      return false
    }
    set {payload = .bool(newValue)}
  }

  var error: SysError {
    get {
      if case .error(let v)? = payload {return v}
      return SysError()
    }
    set {payload = .error(newValue)}
  }

  var sysInited: SysInited {
    get {
      if case .sysInited(let v)? = payload {return v}
      return SysInited()
    }
    set {payload = .sysInited(newValue)}
  }

  var pong: Pong {
    get {
      if case .pong(let v)? = payload {return v}
      return Pong()
    }
    set {payload = .pong(newValue)}
  }

  var authorized: Authorized {
    get {
      if case .authorized(let v)? = payload {return v}
      return Authorized()
    }
    set {payload = .authorized(newValue)}
  }

  var serverTime: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Payload: Equatable {
    case bool(Bool)
    case error(SysError)
    case sysInited(SysInited)
    case pong(Pong)
    case authorized(Authorized)

  #if !swift(>=4.1)
    static func ==(lhs: Response.OneOf_Payload, rhs: Response.OneOf_Payload) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.bool, .bool): return {
        guard case .bool(let l) = lhs, case .bool(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.error, .error): return {
        guard case .error(let l) = lhs, case .error(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.sysInited, .sysInited): return {
        guard case .sysInited(let l) = lhs, case .sysInited(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.pong, .pong): return {
        guard case .pong(let l) = lhs, case .pong(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.authorized, .authorized): return {
        guard case .authorized(let l) = lhs, case .authorized(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  init() {}
}

struct Update {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var pts: UInt64 = 0

  var payload: Update.OneOf_Payload? = nil

  var userUpdated: UpdateUser {
    get {
      if case .userUpdated(let v)? = payload {return v}
      return UpdateUser()
    }
    set {payload = .userUpdated(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Payload: Equatable {
    case userUpdated(UpdateUser)

  #if !swift(>=4.1)
    static func ==(lhs: Update.OneOf_Payload, rhs: Update.OneOf_Payload) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.userUpdated, .userUpdated): return {
        guard case .userUpdated(let l) = lhs, case .userUpdated(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      }
    }
  #endif
  }

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Request: @unchecked Sendable {}
extension Request.OneOf_Payload: @unchecked Sendable {}
extension Response: @unchecked Sendable {}
extension Response.OneOf_Payload: @unchecked Sendable {}
extension Update: @unchecked Sendable {}
extension Update.OneOf_Payload: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension Request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "Request"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "idempotencyKey"),
    3: .same(proto: "sysInit"),
    4: .same(proto: "ping"),
    5: .same(proto: "checkLogin"),
    6: .same(proto: "sendSmsCode"),
    7: .same(proto: "sighIn"),
    8: .same(proto: "signUp"),
    9: .same(proto: "authorize"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.idempotencyKey) }()
      case 3: try {
        var v: SysInit?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .sysInit(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .sysInit(v)
        }
      }()
      case 4: try {
        var v: Ping?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .ping(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .ping(v)
        }
      }()
      case 5: try {
        var v: CheckLogin?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .checkLogin(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .checkLogin(v)
        }
      }()
      case 6: try {
        var v: SendSmsCode?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .sendSmsCode(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .sendSmsCode(v)
        }
      }()
      case 7: try {
        var v: SighIn?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .sighIn(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .sighIn(v)
        }
      }()
      case 8: try {
        var v: SighUp?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .signUp(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .signUp(v)
        }
      }()
      case 9: try {
        var v: Authorize?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .authorize(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .authorize(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.id != 0 {
      try visitor.visitSingularUInt32Field(value: self.id, fieldNumber: 1)
    }
    if !self.idempotencyKey.isEmpty {
      try visitor.visitSingularStringField(value: self.idempotencyKey, fieldNumber: 2)
    }
    switch self.payload {
    case .sysInit?: try {
      guard case .sysInit(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }()
    case .ping?: try {
      guard case .ping(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    }()
    case .checkLogin?: try {
      guard case .checkLogin(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }()
    case .sendSmsCode?: try {
      guard case .sendSmsCode(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    }()
    case .sighIn?: try {
      guard case .sighIn(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    }()
    case .signUp?: try {
      guard case .signUp(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 8)
    }()
    case .authorize?: try {
      guard case .authorize(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 9)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Request, rhs: Request) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.idempotencyKey != rhs.idempotencyKey {return false}
    if lhs.payload != rhs.payload {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "Response"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "idempotencyKey"),
    3: .same(proto: "bool"),
    4: .same(proto: "error"),
    5: .same(proto: "sysInited"),
    6: .same(proto: "pong"),
    7: .same(proto: "authorized"),
    1000: .standard(proto: "server_time"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.idempotencyKey) }()
      case 3: try {
        var v: Bool?
        try decoder.decodeSingularBoolField(value: &v)
        if let v = v {
          if self.payload != nil {try decoder.handleConflictingOneOf()}
          self.payload = .bool(v)
        }
      }()
      case 4: try {
        var v: SysError?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .error(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .error(v)
        }
      }()
      case 5: try {
        var v: SysInited?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .sysInited(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .sysInited(v)
        }
      }()
      case 6: try {
        var v: Pong?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .pong(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .pong(v)
        }
      }()
      case 7: try {
        var v: Authorized?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .authorized(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .authorized(v)
        }
      }()
      case 1000: try { try decoder.decodeSingularUInt64Field(value: &self.serverTime) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.id != 0 {
      try visitor.visitSingularUInt32Field(value: self.id, fieldNumber: 1)
    }
    if !self.idempotencyKey.isEmpty {
      try visitor.visitSingularStringField(value: self.idempotencyKey, fieldNumber: 2)
    }
    switch self.payload {
    case .bool?: try {
      guard case .bool(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularBoolField(value: v, fieldNumber: 3)
    }()
    case .error?: try {
      guard case .error(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    }()
    case .sysInited?: try {
      guard case .sysInited(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }()
    case .pong?: try {
      guard case .pong(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    }()
    case .authorized?: try {
      guard case .authorized(let v)? = self.payload else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    }()
    case nil: break
    }
    if self.serverTime != 0 {
      try visitor.visitSingularUInt64Field(value: self.serverTime, fieldNumber: 1000)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Response, rhs: Response) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.idempotencyKey != rhs.idempotencyKey {return false}
    if lhs.payload != rhs.payload {return false}
    if lhs.serverTime != rhs.serverTime {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Update: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "Update"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "pts"),
    2: .same(proto: "userUpdated"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt64Field(value: &self.pts) }()
      case 2: try {
        var v: UpdateUser?
        var hadOneofValue = false
        if let current = self.payload {
          hadOneofValue = true
          if case .userUpdated(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.payload = .userUpdated(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.pts != 0 {
      try visitor.visitSingularUInt64Field(value: self.pts, fieldNumber: 1)
    }
    try { if case .userUpdated(let v)? = self.payload {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Update, rhs: Update) -> Bool {
    if lhs.pts != rhs.pts {return false}
    if lhs.payload != rhs.payload {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
