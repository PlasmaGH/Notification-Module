--[[

	Written by Plasma,
	@PlasmaRB on Twitter
	
	Notification Types: {
		notification
		question
	}
	
	You can add more by creating your own frame under "OptionButtons" (BaseNotification.OptionButtons).
	The value returned is the button's name.
	
	## Example:
	
	local maid = require(path);
	
	maid.display_Notification(
		notification type (refer to line 6)
		header title (title of notification)
		message content (content of the message.)
	)
	
--]]

--// Services
local PlayerService = game:GetService("Players")

--// Variables
local Base_Notification_Frame = script:WaitForChild("BaseNotification")

local module = {}
local currentData = {};

local maidSettings = {

	["Draw Over UIs"] = true,
	["Display Order"] = 2, -- Use if you disable "Draw Over UIs"!

	["Ignore_Inset"] = true, -- IgnoreGuiInset (top boarder pixel alignment)
}

local LocalPlayer = PlayerService.LocalPlayer or PlayerService:GetPropertyChangedSignal("LocalPlayer") and PlayerService.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 35);

local function create_Notification_Bin()
	local ScreenGui = Instance.new("ScreenGui")

	ScreenGui.Name = "Notification_Bin";
	ScreenGui.DisplayOrder = (maidSettings["Draw Over UIs"]) and 999999999 or maidSettings["Display Order"]
	ScreenGui.IgnoreGuiInset = maidSettings["Ignore_Inset"]

	ScreenGui.Parent = PlayerGui

	return ScreenGui
end

local NotificationBin = PlayerGui:FindFirstChild("Notification_Bin") or create_Notification_Bin();

function module.__getCurrent__Data()
	return currentData;
end

function module.remove_Notification()
	if currentData then

		local messageUI = currentData["MessageUI"];
		local uiSignals = currentData["UISignals"];
		local finishedSignal = currentData["Finished_Signal"]

		if typeof(messageUI) == "Instance" then
			messageUI:Destroy();
		end

		if uiSignals then
			for index, signal in pairs(uiSignals) do
				if signal then
					signal:Disconnect();
				end
			end
		end;

		if finishedSignal then
			finishedSignal:Destroy();
		end

		currentData["Finished_Signal"] = nil;
		currentData["MessageUI"] = nil;
		currentData = {};

	end;
end

function module.display_Notification( notification_Style:string, header_Title:string, message_Content:string)

	module.remove_Notification(); -- Remove previous notification.

	local newNotification = Base_Notification_Frame:Clone();
	local optionButtons = newNotification:WaitForChild("OptionButtons"):WaitForChild(notification_Style);

	local buttonClickedSignals = {}
	local promptFinishSignal = Instance.new("BindableEvent")

	for index, button:GuiButton in pairs(optionButtons:GetChildren()) do
		buttonClickedSignals[button] = button.MouseButton1Click:Connect(function()
			promptFinishSignal:Fire(button);
		end)
	end

	optionButtons.Visible = true;

	newNotification.MessageContent.Text = message_Content;
	newNotification.HeaderLabel.Text = header_Title;

	newNotification.Parent = NotificationBin

	currentData = {
		["NotificationID"] = tostring(tick()),
		["MessageUI"] = newNotification;
		["UISignals"] = buttonClickedSignals;
		["Finished_Signal"] = promptFinishSignal;
	}

	local buttonClicked =  promptFinishSignal.Event:Wait().Name; -- Result
	module.remove_Notification();

	return buttonClicked

end;

return module;
