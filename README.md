[![codecov](https://codecov.io/gh/HYPHENATE/Notification/branch/master/graph/badge.svg)](https://codecov.io/gh/HYPHENATE/Notification)
[![HYPHENATE](https://circleci.com/gh/HYPHENATE/Notification.svg?style=svg&&circle-token=297c83f424a06b21dc3b4fa042318223464f67d7)](https://circleci.com/gh/HYPHENATE/Notification)

# Notification

A simple component that you can load of any Lightning Page to display a field value or check for a specific value of a field or fields to display a specific message from the current record or from parent records. You can set the colour and title within the component and also using native salesforce configuration determine when it should appear and who to.

## Verion Control

### 1.3.0
- upgrade to API 54
- include ability perform a where clause base check for validation on message
- moved to new SLDS Scoped Notification format
- improve accessibility through use of icons to display within component
### 1.0.1
- included unlocked package version configuration
- upgrade to API 50
### 1.0 - Initial release
- Basic Notification component for any object / lightning page internally
- Supports any field type
- Support for parent fields i.e. from Opportunity Account.Name or Account.Owner.Name or Account.Alert_Message__c
- Ability to change the Notification banner colour

## Part 1: Installation

Unlocked Package Installs URLS
- Production: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t67000000xp7KAAQ
- Sandbox: https://test.salesforce.com/packaging/installPackage.apexp?p0=04t67000000xp7KAAQ

1. Ensure my domain is actived and deployed
2. Install using the deploy to salesforce link above
3. Start configuration

## Part 2: Configuration

### Configure Notification
 
* Visit a record that you want to display a notification on
* Press Setup
* Select Edit Page
* Within Components scroll down to Custom
* Find notification
* Drag this into the main builder window to the Location you want to display your notification
* Now you need to configure the following fields:
    * Notification Title
    * Query Field API Name - this is the field value that you want to output on screen - supports pull from parent records up to 5 high
    * Output Styling
    * Notification Icon

### Config Alert

* Visit a record that you want to display a notification on
* Press Setup
* Select Edit Page
* Within Components scroll down to Custom
* Find notification
* Drag this into the main builder window to the Location you want to display your notification
* Now you need to configure the following fields:
    * Notification Title
    * Output Styling
    * Notification Message
    * Notification Criteria
    * Notification Icon


## Part 3: Limitations
- No community support

## Credits
@hyphen8.com
