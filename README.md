[![codecov](https://codecov.io/gh/HYPHENATE/Notification/branch/master/graph/badge.svg)](https://codecov.io/gh/HYPHENATE/Notification)
[![HYPHENATE](https://circleci.com/gh/HYPHENATE/Notification.svg?style=svg&&circle-token=297c83f424a06b21dc3b4fa042318223464f67d7)](https://circleci.com/gh/HYPHENATE/Notification)

# Notification

A simple component that you can load of any Lightning Page to display a field value from the current record or from parent records. You can set the colour and title within the component and also using native salesforce configuration determine when it should appear and who to.

<img src="https://github.com/HYPHENATE/Notification/blob/master/NotificationComponent.png?raw=true" width="800px"/>

## Verion Control

### 1.0.1
- included unlocked package version configuration
- upgrade to API 50
### 1.0 - Initial release
- Basic Notification component for any object / lightning page internally
- Supports any field type
- Support for parent fields i.e. from Opportunity Account.Name or Account.Owner.Name or Account.Alert_Message__c
- Ability to change the Notification banner colour

## Part 1: Installation

<a href="https://githubsfdeploy.herokuapp.com?owner=HYPHENATE&repo=Notification">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

Unlocked Package Installs URLS
- Production: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t67000000SaF0AAK
- Sandbox: https://test.salesforce.com/packaging/installPackage.apexp?p0=04t67000000SaF0AAK

1. Ensure my domain is actived and deployed
2. Install using the deploy to salesforce link above
3. Start configuration

## Part 2: Configuration

1. Edit desired Lightning Page
2. Drag the 'Notification' component onto the page
3. Add in an Alert Title for the Notification Message
4. Add in the field which contains the message you would like to display. This can be from a parent record. For example: 'Account.Description'

 <a href="https://web.microsoftstream.com/embed/video/6aa88747-273b-42cb-95b6-87d10ee7908b?autoplay=false&amp;showinfo=true">Notification Setup Video</a>

## Part 3: Limitations
- No community support

## Credits

