//
//  PlaygroundModule.swift
//  Twoot
//
//  Created by Alexey Rogatkin on 15.05.17.
//
//

import Foundation
import Vapor

public enum PlaygroundModuleError : Error {
    case ConfigFileNotPresenter
}

public protocol PlaygroundModuleProtocol : Vapor.Provider  {

    init()
    
    func configure(with config: Config)
    
    var renderer : ViewRenderer.Type? { get }
    
}

open class PlaygroundModule : PlaygroundModuleProtocol {
    
    private var name : String {
        return String(describing: type(of: self))
    }
    
    public var provided: Providable {
        //deprecated by vapor
        return Providable()
    }
    
    public required convenience init(config: Config) throws {
        self.init()
        
        guard let modulesConfig = config["modules"] else {
            throw PlaygroundModuleError.ConfigFileNotPresenter
        }
        
        if let config = modulesConfig[name] {
            self.configure(with: config)
        }
        
    }
    
    public var renderer : ViewRenderer.Type? {
        return nil
    }
    
    public func boot(_ drop: Droplet) {
        let renderer = self.renderer ?? LeafRenderer.self
        drop.view = renderer.init(viewsDir: "\(drop.viewsDir)/\(name)")
    }
    
    public func afterInit(_ drop: Droplet) {
        
    }
    
    public func beforeRun(_: Droplet) {
        
    }
    
    public required init() {
        
    }

    public func configure(with config: Config) {
        
    }
    
}
