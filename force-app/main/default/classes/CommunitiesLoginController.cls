/**
 * An apex page controller that exposes the site login functionality
 */
global with sharing class CommunitiesLoginController {
    public String username { get; set; }
    public String password { get; set; }
    
    global CommunitiesLoginController () {}
    
    // Code we will invoke on page load.
    global PageReference forwardToAuthPage() {
    	String startUrl = System.currentPageReference().getParameters().get('startURL');
    	String displayType = System.currentPageReference().getParameters().get('display');
        return Network.forwardToAuthPage(startUrl, displayType);
    }
    
	// This is the custom Login Page that Carved Rock will use
    global PageReference redirectToCustomLogin()  {
        return new PageReference( '/CarvedRockLogin');       
    }
    
    // This is the Landing page that users will be directed to after login
    public PageReference loginUser() {
        return Site.Login(username, password, '/CarvedRockLanding');
    }
    
}