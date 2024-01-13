//
//  RequestDispatcher.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/13/24.
//

import Foundation

class TaskQueue {
  
  private actor TaskQueueActor {
    private var blocks : [() async -> Void] = []
    private var currentTask : Task<Void,Never>? = nil
    
    func addBlock(block: @escaping () async -> Void) {
      blocks.append(block)
      next()
    }
    
    func next() {
      if currentTask != nil {
        return
      }
      if !blocks.isEmpty  {
        let block = blocks.removeFirst()
        currentTask = Task {
          await block()
          currentTask = nil
          next()
        }
      }
    }
  }
  private let taskQueueActor = TaskQueueActor()
  
  func enqueue(block: @escaping () async -> Void) {
    Task {
      await taskQueueActor.addBlock(block: block)
    }
  }
}

actor RequestDispatcher {
  private let taskQueue: TaskQueue = TaskQueue()
  private var pendingRequests: [NetworkRequest] = []
  
  func didGet(data: Data) {
    do {
      let req = try Request(serializedData: data)
    } catch {
      
    }
  }
  
  func performReq() async {
    let reqBody = Request.with {
      $0.id = 1
      $0.payload = .sysInit(SysInit.with({
        $0.appID = "df"
        $0.appSecret = "sd"
        $0.seeesionID = "3232"
      }))
    }
    
    let request: NetworkRequest = TCPRequest(id: reqBody.id, request: reqBody)
  }
}
