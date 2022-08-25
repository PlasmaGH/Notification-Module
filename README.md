# Notification-Module
### A simple and easy to use Custom UI Notification Module.

You can grab the model on Roblox for free, here: https://www.roblox.com/library/10712465239/Notification-Maid

---


## Styles "notification_Style" (Argument 1):string

Styles are listed under the default notification frame, they are basically what buttons appear.
__(⚠ reminder that button names are important, if you record the notification function, it will return the name of the button that the user pressed).__

![image](https://user-images.githubusercontent.com/77991203/186697832-1761abe3-5e7f-409b-a4da-0f03131e64f9.png)

## Header "header_Title" (Argument 2):string
The second argument is a header (A basic description of the notification)

## Message Content "message_Content" (Argument 3):string
The final argument is the message content of the notification.

---

## Example:

```lua
local Module = require(game.ReplicatedStorage:WaitForChild("NotificationMaid"))
local Result = Module.display_Notification("question", "Switch Teams?", "Are you sure you want to switch teams?");

if Result == "Option_2" then -- The "Yes" option.
	print("Lets switch teams.");
elseif Result == "Option_1" then -- The "No" option.
	print("Let's stay as this team.")
end
```

![image](https://user-images.githubusercontent.com/77991203/186701179-6b6d1209-6d7c-4067-a610-c690d196776c.png)
