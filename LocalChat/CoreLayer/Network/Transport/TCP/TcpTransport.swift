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
  func socketDidDisconnect()
}

class TcpTransport: @unchecked Sendable {
  private var connection: TcpConnection
  
  weak var requestDispatcher: RequestDispatcher?
  
  enum ConnectionState {
    case none
    case conecting
    case good
  }
  
  private var currentState: ConnectionState = .none
  private var currentReachability: Reachability.Connection = .unavailable
  private var outputTask: Task<(), Never>?
  private let reconectInterval = SmartReconectInterval(with: .linear(duration: .seconds(1)))
  
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
    self.currentReachability = reachability?.connection ?? .unavailable
    startObserveReachability()
    startListenSocketOutput()
  }
  
  func send(request: Request) {
    do {
      let data = try request.serializedData()
      inputSocketContinuation?.yield((data, request.id))
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func start() {
    guard currentState == .none else { return }
    currentState = .conecting
    connection.connect()
  }
  
  func sleep() {
    currentState = .none
    stop()
  }
  
  func reset() {
    stop()
    start()
  }
  
  private func stop() {
    currentState = .none
    connection.disconnect()
  }
  
  private func startListenSocketOutput() {
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
        .filter({ [weak self] newReachability in
          guard let self = self else { return false }
          if self.currentReachability != newReachability.connection {
            if (self.currentReachability == .wifi || self.currentReachability == .cellular) && newReachability.connection == .unavailable {
              return true
            } else if self.currentReachability == .unavailable && (newReachability.connection == .wifi || self.currentReachability == .cellular) {
              return true
            }
          }
          return false
        })
        .sink { [weak self] reachability in
          self?.currentReachability = reachability.connection
          switch reachability.connection {
          case .wifi:
            self?.start()
            Log.network.debug("Reachability status change: WiFi")
          case .cellular:
            self?.start()
            Log.network.debug("Reachability status change: Cellular")
          default:
            self?.stop()
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
  
  func socketDidDisconnect() {
    Task {
      await reconectInterval.startAfterDelay()
      reset()
    }
  }
}
