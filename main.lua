local CV = RegisterMod("CainsVoyage",1) 


local function CV_PlayerInit(_,bool)

    player = Isaac.GetPlayer(0)
    print(type(bool))
    if(player:GetName() == "Cain" and bool == true) then
        player:AddCollectible(CollectibleType.COLLECTIBLE_HEAD_OF_THE_KEEPER)
    end

end

-- local function CV_processCoin(entity)

--     local player = Isaac.GetPlayer(0)
--     print("process coin ran")
--     print(entity)
    
--     if(player:GetName() == "Cain") then
--         local CV_hearts = player.coins / 2  
--         player.hearts = CV_hearts  
--     end


-- end

local function CV_processCoin() -- Renders every frame which isnt efficient, may need to work it into the pickup event (which didnt detect anything)
    local player = Isaac.GetPlayer(0)
    if(player:GetName() == "Cain") then
        local CV_hearts = player:GetNumCoins() 
        if(CV_hearts > player:GetHearts())then
            player:AddHearts(CV_hearts)
        end
        if(player:GetHearts() > CV_hearts)then
            player:AddHearts(-1)
        end
        -- print(player:GetHearts(),CV_hearts)
        end
end

local function CV_removeCoin()

    local player = Isaac.GetPlayer(0)
    if(player:GetName() == "Cain") then
        player:AddCoins(-1)
    end
end

CV:AddCallback(ModCallbacks.MC_POST_UPDATE, CV_processCoin)
CV:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CV_removeCoin,EntityType.ENTITY_PLAYER)

CV:AddCallback(ModCallbacks.MC_POST_GAME_STARTED,CV_PlayerInit) -- Need to change callback to when the run first starts

-- CV:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, CV_processCoin, EntityType.ENTITY_PICKUP)
