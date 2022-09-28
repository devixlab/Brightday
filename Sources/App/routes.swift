import Vapor

/// Register your application's routes here.
func routes(_ app: Application) throws {
    
    // Route for WebsiteController
        let websiteController = WebMainController()
    try app.register(collection: websiteController)
    
    }

