//
//  TCPTransport.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import Foundation
import Combine
import Reachability

protocol TcpTransportInterface: AnyObject {
  var inputSocketStream: AsyncStream<(data: Data, id: UInt32)> { get }
  func socketDidSuccessConnect()
}

class TcpTransport {
  static let shared = TcpTransport()
  private var connection: TcpConnection
  
  weak var requestDispatcher: RequestDispatcher?
  
  enum ConnectionState {
    case none
    case conecting
    case good
  }
  
  private var currentState: ConnectionState = .none
  private var outputTask: Task<(), Never>?
  
  private(set) lazy var inputSocketStream: AsyncStream<(data: Data, id: UInt32)> = {
    AsyncStream { (continuation: AsyncStream<(data: Data, id: UInt32)>.Continuation) -> Void in
      self.inputSocketContinuation = continuation
    }
  }()
  
  private var inputSocketContinuation: AsyncStream<(data: Data, id: UInt32)>.Continuation?
  
  private let timer = Timer.publish(every: 40, on: .current, in: .common)
  private var reachability: Reachability?
  
  private(set) var cancellableSet: Set<AnyCancellable> = []
  
  init() {
    self.connection = TcpConnection()
    self.connection.transport = self
    self.reachability = try? Reachability()
  }
  
  func startListenSocketOutput() {
    outputTask = Task {
      do {
        for try await resivedData in connection.outputSocketStream {
          await requestDispatcher?.didGet(data: resivedData)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func send(request: Request) {
    do {
      let data = try request.serializedData()
      inputSocketContinuation?.yield((data, request.id))
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func setupConnection() {
    currentState = .conecting
    connection.connect()
    startListenSocketOutput()
    startObserveReachability()
  }
  
  private func lendHand() {
    Task {
      do {
        let _ = try await ServicesCatalog.shared.networkService.performSysInitRequest()
        currentState = .good
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  private func startObserveReachability() {
    do {
      try reachability?.startNotifier()
      
      NotificationCenter.default
        .publisher(for: .reachabilityChanged)
        .compactMap({ $0.object as? Reachability })
        .sink { reachability in
          switch reachability.connection {
          case .wifi:
            Log.network.debug("Reachability status change: WiFi")
          case .cellular:
            Log.network.debug("Reachability status change: Cellular")
          default:
            Log.network.debug("Reachability status change: No connection")
          }
        }
        .store(in: &cancellableSet)
    } catch {
      Log.network.debug("Reachability connect error: \(error.localizedDescription)")
    }
  }
}

extension TcpTransport: TcpTransportInterface {
  func socketDidSuccessConnect() {
    lendHand()
  }
}
