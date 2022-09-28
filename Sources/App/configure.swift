import Leaf
import Vapor
import SendGrid

// configures your application
public func configure(_ app: Application) throws {
    
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.middleware.use(app.sessions.middleware)

    app.views.use(.leaf)
    
    app.sendgrid.initialize()
    
    // register routes
    try routes(app)
}
