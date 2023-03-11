# AppSytle Sizes

## Colors
- color: Colors.white,
  
## Sizes
- logins title 25
- login subtitle 15
- login button fontSize 22
- Login Forgot Password text 14
- Sign in button text size 22
- Don't have an account 13
- Sign up, Already have an account
- Sign up text ? 14 / login text on sign up
- Sign in with google 22
- password reset button text 22
- Clinic list names 18
- address 16.0
- Tabs for clinic details 16
- Book pointment text labels 16
- book appointment button text 22
- About image height 200
- About clinic name-20
- clinic address name-16
- Description title-18
- Clinic description -16
- Preview header- 18
- Reviews header - 18
###
- 
## Padding


### Images
- clinic svg height 250
- Clinic image width:100, height 120


### Icon Size
- bottom icons 24


[
    25,15,22,14,22,13,14, 22,22,18,16,16,16,16,22,20,16,18,16,18,18
]


Flutter, I have the following text fontSizes 25,16,22,14,12,18,20, I want to create a styles for my screens, but i dont know which should be heading1 or smalltext or normal text. I have this code that helps in determining the screen sizes  if (_size.width >= 1024) {
      return desktop!;
    } else if (_size.height >= 740) {
      return tallmobile!;
    } else if (_size.width >= 600 && tablet != null) {
      return tablet!;
    } else if (_size.width >= 600 && mobileLarge != null) {
      return mobileLarge!;
    } else {
      return mobile!;
    }  The textSytle that i want should take in the font color and fontweight since the texts have different properties The Code that i intent should be something like  
      static TextStyle heading2(BuildContext context, //parameters fontWeight and fontColor) {
    return TextStyle(
        color: fontColor,
        fontSize: Responsive.isTablet(context)
            ? Your prefed fontSize that should be good
            //Then for all the screens
            // I would like best fontSizes that google uses on their apps but should for mobileLarge should stick to the fontsize that i have provided above
        fontWeight: fontWeight;
  }
  

  Can you help in making my app responsive?
