// 
//  PhotoViewerModelProtocol.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/24.
//

import Foundation

protocol PhotoViewerModelActionsProtocol: AnyObject {
  
}

protocol PhotoViewerModelStateProtocol {
  var routerSubject:PhotoViewerRouter.Subjects { get }
}

// MARK: - Route
protocol PhotoViewerModelRouterProtocol: AnyObject {
  
}
