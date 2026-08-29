local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Icy's Locks Script",
   Icon = 0,
   LoadingTitle = "Icy's Interface Suite",
   LoadingSubtitle = "by Icy",
   Theme = "Ocean",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = true,
   KeySettings = {
      Title = "Icy's Lock | Key",
      Subtitle = "In Video Discription",
      Note = "Join Discord For More",
      FileName = "IcysHoodKey",
      SaveKey = false,
      GrabKeyFromSite = true,
      Key = {"https://pastebin.com/raw/s1hjMkBe"}
   }
})


-----------------------------------------------------------
-- HOME TAB
-----------------------------------------------------------

local MainTab = Window:CreateTab("🏠 Home", nil)
local MainSection = MainTab:CreateSection("Combat")


Rayfield:Notify({
   Title = "You successfully excuted the Script!",
   Content = "Lock Gui",
   Duration = 4.5,
   Image = nil,
})


-----------------------------------------------------------
-- AIM LOCK | Q
-----------------------------------------------------------

local AimLockButton = MainTab:CreateButton({
   Name = "Aim Lock | Q",

   Callback = function()

      local player = game.Players.LocalPlayer
      local camera = game.Workspace.CurrentCamera
      local userInputService = game:GetService("UserInputService")

      local aimAssistRange = 50
      local aimSpeed = 0.2

      local lockedTarget = nil
      local isAimAssistEnabled = false


      local function createTargetIndicator(target)

         if not target
            or not target.Character
            or not target.Character:FindFirstChild("HumanoidRootPart") then
            return
         end

         local billboard = Instance.new("BillboardGui")

         billboard.Name = "IcyAimIndicator"
         billboard.Adornee =
            target.Character.HumanoidRootPart

         billboard.Size =
            UDim2.new(0, 10, 0, 10)

         billboard.StudsOffset =
            Vector3.new(0, 2, 0)

         billboard.Parent =
            target.Character


         local frame = Instance.new("Frame")

         frame.Size =
            UDim2.new(1, 0, 1, 0)

         frame.BackgroundColor3 =
            Color3.fromRGB(255, 0, 0)

         frame.BackgroundTransparency =
            0.5

         frame.Parent = billboard

      end


      local function removeTargetIndicator(target)

         if target and target.Character then

            local billboard =
               target.Character:FindFirstChild(
                  "IcyAimIndicator"
               )

            if billboard then
               billboard:Destroy()
            end

         end

      end


      local function getClosestEnemy()

         local closestEnemy = nil
         local shortestDistance = aimAssistRange

         if not player.Character then
            return nil
         end

         local root =
            player.Character:FindFirstChild(
               "HumanoidRootPart"
            )

         if not root then
            return nil
         end


         for _, otherPlayer in
            ipairs(game.Players:GetPlayers()) do

            if otherPlayer ~= player
               and otherPlayer.Character
               and otherPlayer.Character:FindFirstChild(
                  "HumanoidRootPart"
               ) then

               local distance =
                  (
                     root.Position -
                     otherPlayer.Character.HumanoidRootPart.Position
                  ).Magnitude


               if distance < shortestDistance then

                  closestEnemy =
                     otherPlayer

                  shortestDistance =
                     distance

               end

            end
         end


         return closestEnemy
      end


      local function smoothCameraAim(target)

         if not target
            or not target.Character
            or not target.Character:FindFirstChild(
               "HumanoidRootPart"
            ) then
            return
         end


         local targetPos =
            target.Character.HumanoidRootPart.Position


         camera.CFrame =
            camera.CFrame:Lerp(
               CFrame.lookAt(
                  camera.CFrame.Position,
                  targetPos
               ),
               aimSpeed
            )

      end


      userInputService.InputBegan:Connect(
         function(input, gameProcessed)

            if gameProcessed then
               return
            end


            if input.UserInputType ==
               Enum.UserInputType.Keyboard
               and input.KeyCode ==
               Enum.KeyCode.Q then

               isAimAssistEnabled =
                  not isAimAssistEnabled


               if isAimAssistEnabled then

                  lockedTarget =
                     getClosestEnemy()


                  if lockedTarget then

                     print(
                        "Aim Assist Enabled - Locked onto "
                        .. lockedTarget.Name
                     )

                     createTargetIndicator(
                        lockedTarget
                     )

                  else

                     print(
                        "Aim Assist Enabled - No target in range"
                     )

                  end

               else

                  print("Aim Assist Disabled")


                  if lockedTarget then

                     removeTargetIndicator(
                        lockedTarget
                     )

                  end


                  lockedTarget = nil

               end
            end
         end
      )


      game:GetService(
         "RunService"
      ).Heartbeat:Connect(
         function()

            if isAimAssistEnabled
               and lockedTarget then

               smoothCameraAim(
                  lockedTarget
               )

            end

         end
      )

   end,
})


-----------------------------------------------------------
-- HEAD LOCK | E
-----------------------------------------------------------

local HeadLockButton = MainTab:CreateButton({
   Name = "Head Lock | E",

   Callback = function()

      local player =
         game.Players.LocalPlayer

      local camera =
         game.Workspace.CurrentCamera

      local userInputService =
         game:GetService("UserInputService")


      local aimAssistRange = 100
      local aimSpeed = 0.2

      local lockedTarget = nil
      local isAimAssistEnabled = false


      local function createTargetIndicator(target)

         if not target
            or not target.Character
            or not target.Character:FindFirstChild("Head") then
            return
         end


         local billboard =
            Instance.new("BillboardGui")


         billboard.Name =
            "IcyHeadIndicator"


         billboard.Adornee =
            target.Character.Head


         billboard.Size =
            UDim2.new(0, 10, 0, 10)


         billboard.StudsOffset =
            Vector3.new(0, 2, 0)


         billboard.Parent =
            target.Character


         local frame =
            Instance.new("Frame")


         frame.Size =
            UDim2.new(1, 0, 1, 0)


         frame.BackgroundColor3 =
            Color3.fromRGB(255, 0, 0)


         frame.BackgroundTransparency =
            0.5


         frame.Parent =
            billboard

      end


      local function removeTargetIndicator(target)

         if target and target.Character then

            local billboard =
               target.Character:FindFirstChild(
                  "IcyHeadIndicator"
               )


            if billboard then
               billboard:Destroy()
            end

         end

      end


      local function getClosestEnemy()

         local closestEnemy = nil
         local shortestDistance =
            aimAssistRange


         if not player.Character then
            return nil
         end


         local root =
            player.Character:FindFirstChild(
               "HumanoidRootPart"
            )


         if not root then
            return nil
         end


         for _, otherPlayer in
            ipairs(game.Players:GetPlayers()) do

            if otherPlayer ~= player
               and otherPlayer.Character
               and otherPlayer.Character:FindFirstChild(
                  "Head"
               ) then


               local distance =
                  (
                     root.Position -
                     otherPlayer.Character.Head.Position
                  ).Magnitude


               if distance < shortestDistance then

                  closestEnemy =
                     otherPlayer

                  shortestDistance =
                     distance

               end

            end
         end


         return closestEnemy

      end


      local function smoothCameraAim(target)

         if not target
            or not target.Character
            or not target.Character:FindFirstChild(
               "Head"
            ) then
            return
         end


         local targetPos =
            target.Character.Head.Position


         camera.CFrame =
            camera.CFrame:Lerp(
               CFrame.lookAt(
                  camera.CFrame.Position,
                  targetPos
               ),
               aimSpeed
            )

      end


      userInputService.InputBegan:Connect(
         function(input, gameProcessed)

            if gameProcessed then
               return
            end


            if input.UserInputType ==
               Enum.UserInputType.Keyboard
               and input.KeyCode ==
               Enum.KeyCode.E then


               isAimAssistEnabled =
                  not isAimAssistEnabled


               if isAimAssistEnabled then

                  lockedTarget =
                     getClosestEnemy()


                  if lockedTarget then

                     print(
                        "Head Lock Enabled - Locked onto "
                        .. lockedTarget.Name
                     )


                     createTargetIndicator(
                        lockedTarget
                     )

                  else

                     print(
                        "Head Lock Enabled - No target in range"
                     )

                  end


               else

                  print(
                     "Head Lock Disabled"
                  )


                  if lockedTarget then

                     removeTargetIndicator(
                        lockedTarget
                     )

                  end


                  lockedTarget = nil

               end
            end
         end
      )


      game:GetService(
         "RunService"
      ).Heartbeat:Connect(
         function()

            if isAimAssistEnabled
               and lockedTarget then

               smoothCameraAim(
                  lockedTarget
               )

            end

         end
      )

   end,
})


-----------------------------------------------------------
-- PREDICTION
-----------------------------------------------------------

local ReplicatedStorage =
   game:GetService("ReplicatedStorage")

local Workspace =
   game:GetService("Workspace")


local Knit =
   require(
      ReplicatedStorage.Packages.Knit
   )


repeat
   task.wait()
until Knit.Player


local PitchingController =
   Knit.GetController(
      "PitchingController"
   )


local PredictionEnabled = false
local TrajectoryParts = {}


local VisualFolder =
   Instance.new("Folder")


VisualFolder.Name =
   "TrajectoryVisuals"


VisualFolder.Parent =
   Workspace


-----------------------------------------------------------
-- BEZIER CALCULATION
-----------------------------------------------------------

local function QuadraticBezier(
   p0,
   p1,
   p2,
   t
)

   t = math.clamp(
      t,
      0,
      1
   )


   return
      (1 - t)^2 * p0
      +
      2 * (1 - t) * t * p1
      +
      t^2 * p2

end


-----------------------------------------------------------
-- CLEAR PREDICTION
-----------------------------------------------------------

local function ClearTrajectory()

   for _, part in
      ipairs(TrajectoryParts) do

      if part
         and part.Parent then

         part:Destroy()

      end

   end


   table.clear(
      TrajectoryParts
   )

end


-----------------------------------------------------------
-- CREATE PREDICTION LINE
-----------------------------------------------------------

local function CreateLine(
   startPos,
   endPos
)

   local distance =
      (endPos - startPos).Magnitude


   if distance <= 0 then
      return
   end


   local line =
      Instance.new("Part")


   line.Name =
      "PredictionLine"


   line.Anchored =
      true


   line.CanCollide =
      false


   line.CanTouch =
      false


   line.CanQuery =
      false


   line.Material =
      Enum.Material.Neon


   line.Color =
      Color3.fromRGB(
         0,
         255,
         255
      )


   line.Size =
      Vector3.new(
         0.12,
         0.12,
         distance
      )


   line.CFrame =
      CFrame.lookAt(
         startPos,
         endPos
      )
      *
      CFrame.new(
         0,
         0,
         -distance / 2
      )


   line.Parent =
      VisualFolder


   table.insert(
      TrajectoryParts,
      line
   )

end


-----------------------------------------------------------
-- DRAW PREDICTION
-----------------------------------------------------------

local function DrawPrediction(
   startPos,
   controlPoint,
   endPos
)

   ClearTrajectory()


   if not startPos
      or not controlPoint
      or not endPos then

      return

   end


   local segments = 50

   local lastPosition =
      startPos


   for i = 1, segments do

      local t =
         i / segments


      local currentPosition =
         QuadraticBezier(
            startPos,
            controlPoint,
            endPos,
            t
         )


      CreateLine(
         lastPosition,
         currentPosition
      )


      lastPosition =
         currentPosition

   end

end


-----------------------------------------------------------
-- PREDICTION TOGGLE
-----------------------------------------------------------

local PredictionToggle =
   MainTab:CreateToggle({

      Name = "Prediction",

      CurrentValue = false,

      Flag = "Prediction",

      Callback = function(Value)

         PredictionEnabled =
            Value


         if not Value then
            ClearTrajectory()
         end


         Rayfield:Notify({

            Title = "Prediction",

            Content =
               Value
               and "Prediction Enabled"
               or "Prediction Disabled",

            Duration = 2,

         })

      end,

   })


-----------------------------------------------------------
-- THROW PITCH
-----------------------------------------------------------

local OldThrowPitch =
   PitchingController.ThrowPitch


PitchingController.ThrowPitch =
   function(
      self,
      pitcher,
      pitchData,
      throwType
   )

      local result =
         OldThrowPitch(
            self,
            pitcher,
            pitchData,
            throwType
         )


      if PredictionEnabled
         and pitchData then


         local startPos =
            pitchData[2]


         local controlPoint =
            pitchData[3]


         local endPos =
            pitchData[4]


         if startPos
            and controlPoint
            and endPos then


            DrawPrediction(
               startPos,
               controlPoint,
               endPos
            )

         end

      end


      return result

   end


print(
   "Icy's Locks Script loaded with Prediction"
)
