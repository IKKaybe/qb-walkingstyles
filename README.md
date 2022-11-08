# qb-walkingstyles

## Original Repo 

```https://github.com/Nathan-FiveM/qb-walkingstyles```
## Edit By Kaybe Scripts

## Persistent Walking Styles

![image](https://i.imgur.com/F0WWeYo.png)

### Installation

- You will need to add this to the following locations

```TriggerServerEvent('qb-walkstyles:server:walkstyles', 'get')```
Add this line to -

Inside qb-ambulancejob/client/main.lua - `hospital:client:Revive` after 
```lua
    TriggerServerEvent('hud:server:RelieveStress', 100)
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent("hospital:server:SetLaststandStatus", false)
```

Inside qb-smallresources/client/crouchprone.lua - `ResetAnimSet()` after
```lua
        RemoveAnimSet(walkSet)
    end
```

Inside qb-spawn/client/client.lua - `PostSpawnPlayer()` after 
```lua
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(250)
```


# Dependencies
[qb-menu](https://github.com/qbcore-framework/qb-menu)

# Command
```/walking-style``` opens menu to change current walking style