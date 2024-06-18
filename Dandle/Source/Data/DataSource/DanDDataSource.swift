//
//  DanDDataSource.swift
//  Dandle
//
//  Created by dev상금 on 6/14/24.
//

import Foundation

public class DanDDataSource <RM, CH> {
  let remote: RM
  let cache: CH
  
  public init(remote: RM, cache: CH) {
    self.remote = remote
    self.cache = cache
  }
}
