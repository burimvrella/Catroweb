@homepage @disabled
Feature: Open Authentication
  I want to be able to sign in as Facebook and Google+ user

  Background:
    Given there are users:
      | name            | password  | token      | email                           |
      | Catrobat        | 123456    | cccccccccc | dev1@pocketcode.org             |
      | AlreadyinDB     | 642135    | cccccccccc | dev2@pocketcode.org             |

  @javascript @insulated
  Scenario: Login with a new user into Facebook, logout and login again with the now existing user
    Given I am on homepage
    When I trigger Facebook login with auth_type 'reauthenticate'
    And I click Facebook login link
    And I switch to popup window
    Then I log in to Facebook with valid credentials
    And I choose the username 'HeyWickieHey'
    Then I should be logged in
    And there is a user in the database:
      | name              | email                              | facebook_uid      | facebook_name | google_uid             | google_name        |country |
      | HeyWickieHey      | pocket_zlxacqt_tester@tfbnw.net    | 105678789764016   |               |                        |                    | en_US  |
    And I should see an "#btn-logout" element
    When I click the "logout" button
    Then I should not be logged in
    When I trigger Facebook login with auth_type ''
    And I click Facebook login link
    And I wait for a second
    Then I should be logged in

  @javascript @insulated
  Scenario: Login with a new user into Google+, logout and login again with the now existing user
    Given I am on homepage
    When I trigger Google login with approval prompt "force"
    And I click Google login link "twice"
    And I switch to popup window
    Then I log in to Google with valid credentials
    And I choose the username 'PocketGoogler'
    Then I should be logged in
    And there is a user in the database:
      | name              | email                              | facebook_uid      | facebook_name | google_uid             | google_name        |country |
      | PocketGoogler     | pocketcodetester@gmail.com         |                   |               | 105155320106786463089  |                    | de     |
    And I should see an "#btn-logout" element
    When I click the "logout" button
    Then I should not be logged in
    When I trigger Google login with approval prompt "auto"
    And I click Google login link "once"
    And I wait for a second
    Then I should be logged in

  @javascript @insulated
  Scenario: Try to login with a new user into Facebook where the username already exists
    Given I am on homepage
    When I trigger Facebook login with auth_type 'reauthenticate'
    And I click Facebook login link
    And I switch to popup window
    Then I log in to Facebook with valid credentials
    And I choose the username 'AlreadyinDB'
    Then I should see "Username already taken, please choose a different one."

  @javascript @insulated
  Scenario: Try to login with a new user into Google+ where the username already exists
    Given I am on homepage
    When I trigger Google login with approval prompt "force"
    And I click Google login link "twice"
    And I switch to popup window
    Then I log in to Google with valid credentials
    And I choose the username 'AlreadyinDB'
    Then I should see "Username already taken, please choose a different one."

  @javascript @insulated
  Scenario: As an OAuth user it should not be possible to change the password on the profile page or to reset the password
    Given I am on homepage
    When I trigger Facebook login with auth_type 'reauthenticate'
    And I click Facebook login link
    And I switch to popup window
    Then I log in to Facebook with valid credentials
    And I choose the username 'HeyWickieHey'
    Then I should be logged in
    And there is a user in the database:
      | name              | email                              | facebook_uid      | facebook_name | google_uid             | google_name        |country |
      | HeyWickieHey      | pocket_zlxacqt_tester@tfbnw.net    | 105678789764016   |               |                        |                    | en_US  |
    And I should see an "#btn-logout" element
    And I should see an "#btn-profile" element
    When I click the "profile" button
    And I wait for a second
    Then I should not see an "#password" element
    And I should not see an "#repeat-password" element
    And I should see an "#btn-logout" element
    And I click the "logout" button
    Then I should not be logged in
    When I trigger Facebook login with auth_type ''
    And I click the "forgot pw or username" button
    And I wait for a second
    Then I should see an "#username" element
    When I fill in "username" with "HeyWickieHey"
    And I press "reset_pw"
    And I wait for a second
    Then I should see "Facebook and Google+ users do not have a password to reset."

  @javascript @insulated
  Scenario: It should be possible to change the E-Mail address on the profile page and login again with the same Facebook account
    Given I am on homepage
    When I trigger Facebook login with auth_type 'reauthenticate'
    And I click Facebook login link
    And I switch to popup window
    Then I log in to Facebook with valid credentials
    And I choose the username 'HeyWickieHey'
    Then I should be logged in
    And there is a user in the database:
      | name              | email                              | facebook_uid      | facebook_name | google_uid             | google_name        |country |
      | HeyWickieHey      | pocket_zlxacqt_tester@tfbnw.net    | 105678789764016   |               |                        |                    | en_US  |
    And I should see an "#btn-logout" element
    And I should see an "#btn-profile" element
    When I click the "profile" button
    And I wait for a second
    Then I fill in "email" with "pocket_tester@tfbnw.net"
    And I press "save changes"
    Then I wait for the server response
    And I should see "saved!"
    When I go to "/logout"
    Then I should not be logged in
    When I trigger Facebook login with auth_type ''
    And I click Facebook login link
    And I wait for a second
    Then I should be logged in
    And I should see an "#btn-profile" element
    When I click the "profile" button
    And I wait for a second
    Then the "email" field should contain "pocket_tester@tfbnw.net"

  @javascript @insulated
  Scenario: It should be possible to change the E-Mail address on the profile page and login again with the same Google+ account
    Given I am on homepage
    When I trigger Google login with approval prompt "force"
    And I click Google login link "twice"
    And I switch to popup window
    Then I log in to Google with valid credentials
    And I choose the username 'PocketGoogler'
    Then I should be logged in
    And there is a user in the database:
      | name              | email                              | facebook_uid      | facebook_name | google_uid             | google_name        |country |
      | PocketGoogler     | pocketcodetester@gmail.com         |                   |               | 105155320106786463089  |                    | de     |
    And I should see an "#btn-logout" element
    And I should see an "#btn-profile" element
    When I click the "profile" button
    And I wait for a second
    Then I fill in "email" with "pocket-code-tester@gmail.com"
    And I press "save changes"
    Then I wait for the server response
    And I should see "saved!"
    When I reload the page
    Then the "email" field should contain "pocket-code-tester@gmail.com"
    When I go to "/logout"
    Then I should not be logged in
    When I trigger Google login with approval prompt "auto"
    And I click Google login link "once"
    And I wait for a second
    Then I should be logged in
    And I should see an "#btn-profile" element
    When I click the "profile" button
    And I wait for a second
    Then the "email" field should contain "pocket-code-tester@gmail.com"
