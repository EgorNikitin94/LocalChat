//
//  MediaPickerModelProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import UIKit

protocol MediaPickerModelActionsProtocol: AnyObject {
  func didLoadPhotosFromLibrary(_ images: [UIImage])
  func didSelectItem(_ item: PhotoDisplayItem)
}

protocol MediaPickerModelStateProtocol {
  var imagesDisplayItems: [PhotoDisplayItem] { get }
  var routerSubject:MediaPickerRouter.Subjects { get }
}

// MARK: - Route
protocol MediaPickerModelRouterProtocol: AnyObject {
  func closeModule()
}
