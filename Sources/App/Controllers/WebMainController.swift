import Vapor
import Leaf
import SendGrid


// New MainController type conforms to RouteCollection
struct WebMainController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        
        
        // Register indexHandler(_:) to process GET request to the router's root path, /.
        routes.get(use: indexHandler)
        // routes.post(ContactFormData.self, at: "/", use: contactFormPostHandler)
        
        // Register servicesHandler
        routes.get("services", use: servicesHandler)
        
        // Register aboutHandler
        routes.get("about", use: aboutHandler)
        
        //Register faqsHandler
        routes.get("faqs", use: faqsHandler)
        
        // Register contactFormHandler
        routes.get("contactForm", use: contactFormHandler)
        
        
        //Register privacyHandler
        routes.get("privacy", use: privacyHandler)
        
    }
    
    // Implament indexHandler(_:) that returns Future<View>
    func indexHandler(_ req: Request)
    -> EventLoopFuture<View> {
        
        // See if a cookie called cookies-accepted exists if not, set showCookieMessage flag to true
        let showCookieMessage = req.cookies["cookies-accepted"] == nil
        
        // Create a token with 16 bytes of randomly data, Base64 encoded.
        let token = [UInt8].random(count: 16).base64
        
        // Save the token into the request's session data under the CSRF_TOKEN key.
        req.session.data["CSRF_TOKEN"] = token
        
        // Pass the flag to IndexContext so the templete knows to show the message.
        let context = IndexContext(
            pageTitle: "Home page",
            pageDescription: "Offering services that can, bridge the gap between needs and means for organizations of all sizes.",
            pageKeywords: "goal realization, business consulting, technology, solution pathways",
            showCookieMessage: showCookieMessage,
            csrfToken: token)
            
        
        // Render the index template and return the result
        return req.view.render("index", context)
    }
    
    // Implament servicesHandler
    func servicesHandler(_ req: Request)
    -> EventLoopFuture<View> {
        
        // See if a cookie called cookies-accepted exists if not, set showCookieMessage flag to true
        let showCookieMessage = req.cookies["cookies-accepted"] == nil
        
        // Create a token with 16 bytes of randomly data, Base64 encoded.
        let token = [UInt8].random(count: 16).base64
        
        // Save the token into the request's session data under the CSRF_TOKEN key.
        req.session.data["CSRF_TOKEN"] = token
        
        // Pass the flag to ServicesContext so the templete knows to show the message.
        let context = ServicesContext(
            pageTitle: "Services",
            pageDescription: "What services we offer at BrightDay Technology",
            pageKeywords: "",
            showCookieMessage: showCookieMessage,
            csrfToken: token)
        
        //Render the Services templete and return the result.
        return req.view.render("services", context)
    }
    
    // Implament aboutHandler
    func aboutHandler(_ req: Request)
    -> EventLoopFuture<View> {
        
        // See if a cookie called cookies-accepted exists if not, set showCookieMessage flag to true
        let showCookieMessage = req.cookies["cookies-accepted"] == nil
        
        // Create a token with 16 bytes of randomly data, Base64 encoded.
        let token = [UInt8].random(count: 16).base64
        
        // Save the token into the request's session data under the CSRF_TOKEN key.
        req.session.data["CSRF_TOKEN"] = token
        
        // Pass the flag to AboutContext so the templete knows to show the message.
        let context = AboutContext(
            pageTitle: "About",
            pageDescription: "Enable thru using business building blocks and effective use of technology.",
            pageKeywords: "business resource, enable, expand, achieve goals",
            showCookieMessage: showCookieMessage,
            csrfToken: token)
        
        //Render the Services templete and return the result.
        return req.view.render("about", context)
    }
    
    // Implament faqsHandler
    func faqsHandler(_ req: Request)
    -> EventLoopFuture<View> {
        
        // See if a cookie called cookies-accepted exists if not, set showCookieMessage flag to true
        let showCookieMessage = req.cookies["cookies-accepted"] == nil
        
        // Create a token with 16 bytes of randomly data, Base64 encoded.
        let token = [UInt8].random(count: 16).base64
        
        // Save the token into the request's session data under the CSRF_TOKEN key.
        req.session.data["CSRF_TOKEN"] = token
        
        // Pass the flag to FaqsContext so the template know to show the message.
        let context = FaqsContext(
            pageTitle: "FAQ's",
            pageDescription: "Frequently asked questions about our services",
            pageKeywords: "BrightDay Technology FAQ's, BrightDay questions",
            showCookieMessage: showCookieMessage,
            csrfToken: token)
        
        // Render the FAQS templete and return the result.
        return req.view.render("faqs", context)
        
    }
        
        // Implament privacyHandler
        func privacyHandler(_ req: Request)
        -> EventLoopFuture<View> {
        
        // See if a cookie called cookies-accepted exists if not, set showCookieMessage flag to true
        let showCookieMessage = req.cookies["cookies-accepted"] == nil
        
        // Create a token with 16 bytes of randomly data, Base64 encoded.
        let token = [UInt8].random(count: 16).base64
        
        // Save the token into the request's session data under the CSRF_TOKEN key.
        req.session.data["CSRF_TOKEN"] = token
        
        let context = PrivacyContext(
            pageTitle: "Site Privacy Policy",
            pageDescription: "",
            pageKeywords: "privacy policy",
            showCookieMessage: showCookieMessage,
            csrfToken: token)
        
        return req.view.render("privacy", context)
    }
    
    func contactFormHandler(_ req: Request)
    -> EventLoopFuture<View> {
        
        let context = FormContext(pageTitle: "Let's Discuss")
        
       return req.view.render("contactForm", context)
    }
    

// Variables types.
struct IndexContext: Encodable {
    let pageTitle: String
    let pageDescription: String
    let pageKeywords: String
    let showCookieMessage: Bool
    let csrfToken: String
}

struct ServicesContext: Encodable {
    let pageTitle: String
    let pageDescription: String
    let pageKeywords: String
    let showCookieMessage: Bool
    let csrfToken: String
}

struct AboutContext: Encodable {
    let pageTitle: String
    let pageDescription: String
    let pageKeywords: String
    let showCookieMessage: Bool
    let csrfToken: String
}

struct FaqsContext: Encodable {
    let pageTitle: String
    let pageDescription: String
    let pageKeywords: String
    let showCookieMessage: Bool
    let csrfToken: String
}

struct PrivacyContext: Encodable {
    let pageTitle: String
    let pageDescription: String
    let pageKeywords: String
    let showCookieMessage: Bool
    let csrfToken: String
}

struct FormContext: Encodable {
    let pageTitle: String

}

struct ContactFormData: Content {
    let FirstName: String
    let LastName: String
    let EmailAddress: String
    let csrfToken: String?
    
}


}
