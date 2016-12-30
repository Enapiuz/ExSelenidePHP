<?php

use Selenide\By;
use Selenide\Condition;

class UsernameSavingTest extends Testing_SeleniumTestCase
{
    function testUsernameSaving
    {
        $new_user = Obj_User::create();
        Testing_Cleanup::addUser($new_user);
        $new_user->verifyEmail();
        Testing_Web_User::loginWithoutRole($new_user->email, $new_user->password);
        $this->selenide()->open('/profile');
        $this->selenide()->find(By::xpath("text()='Settings'"))->click();
        $this->selenide()->find(By::id("username"))->setValue("PewUser");
        $this->selenide()->find(By::text("Save"))->click();
        $this->selenide()->find(By::id("username"))->assert(Condotion::value("PewUser"));
        $this->selenide()->find(By::css(".title"))->assert(Condotion::text("Settings"));
    }
}
