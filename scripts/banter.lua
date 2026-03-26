return function(modApi)
    local DECKER = 1
    local SHALEM = 2
    local XU = 3
    local BANKS = 4
    local NIKA = 6
    local MARIA = 5
    local SHARP = 7
    local PRISM = 8
    local MONSTER = 100
    local CENTRAL = 108
    local OLIVIA = 1000
    local DEREK = 1001
    local RUSH = 1002
    local DRACO = 1003
    local PEDLER = "mod_01_pedler"
    local MIST = "mod_02_mist"
    local GHUFF = "mod_03_ghuff"
    local NUMI = "mod_04_n_umi"
    local DOSAN = "dosan_01"
    local CONWAY = "gunpoint_conway"
    local RED = "transistor_red"
    local SOMBRA = "SOMBRA_001"
    local WIDOWMAKER = "WIDOWMAKER_001"
    local CARMEN = "carmen_sandiego_o"
    local AGENT47 = "agent_47_o"
    local GOOSE = "mod_goose"
    local TOOSE = "mod_goose_2"
    local URIST = "urist"
    local FIASCO = "saderfiasco"
    local JEN = "tbw_jen"
    local ZAN = "tbw_zan"
    local DESSA = "tbw_dessa"
    local DALL = "tbw_dall"
    local RION = "tbw_rion"
    local LUNA4S = "luna4s"
    local IMPOSTER = "IMPOSTER"

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, GOOSE},
            dialogue = {
                {GOOSE, "< HONK >"},
                {LUNA4S, "< hoot >"},
            },
        })

    -- By: Pupp;
    modApi:addBanter({
            agents = {LUNA4S, GOOSE},
            dialogue = {
                {GOOSE, "< HONK >"},
                {LUNA4S, "Ben je betoeterd?!"},
            },
        })
    
    -- By: Pupp;
    modApi:addBanter({
            agents = {LUNA4S, GOOSE},
            dialogue = {
                {GOOSE, "< FLAP >"},
                {LUNA4S, "Oh thankyou, I love your feathers too!"},
            },
        })
    
    -- By: Pupp;
    modApi:addBanter({
            agents = {LUNA4S, GOOSE},
            dialogue = {
                {GOOSE, " !!! "},
                {LUNA4S, "Oh, sorry, let me turn this off-"},
                {GOOSE, " < HONK HONK HON- > "},
                {LUNA4S, "On second thought..."},
            },
        })

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, IMPOSTER},
            dialogue = {
                {IMPOSTER, " [I heard < Luna > vent] "},
                {LUNA4S, "No, you didn't. You didn't hear anything."},
            },
        })

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, IMPOSTER},
            dialogue = {
                {IMPOSTER, " [< Luna > is cute] "},
                {LUNA4S, "Nuh-uh!"},
                {IMPOSTER, " [< Luna > is sus] "},
                {LUNA4S, "Sure, I'll take that."},
            },
        })

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, DRACO},
            dialogue = {
                {LUNA4S, "Banu Haqim?"},
                {DRACO, "I know not what you speak of, haunted one."},
            },
        })
    
    -- By: Pupp;
    modApi:addBanter({
            agents = {LUNA4S, DRACO},
            dialogue = {
                {DRACO, "Doesn't the bright white outfit spoil your hunt?"},
                {LUNA4S, "Owls terrorize the night just as much as bats do."},
            },
        })

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, DECKER},
            dialogue = {
                {DECKER, "So much for 'not leaving tracks'. Your hair just dropped a feather."},
                {LUNA4S, "Keep it! It goes well with your hat."},
            },
        })

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, MARIA},
            dialogue = {
                {LUNA4S, "The owl feathers don't interfere with your emitter, do they?"},
                {MARIA, "It takes more than harmless soundwaves to stop me."},
                {LUNA4S, "But it is enough to silence the people."},
                {MARIA, "That doesn't stop them. It only makes them develop new tactics."},
            },
        })

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, NIKA},
            dialogue = {
                {NIKA, "The scarf is dangerous. It will be used against you in combat."},
                {LUNA4S, "I would think the same of your necktie."},
                {NIKA, "It is clipped on. See?"},
            },
        })

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, BANKS},
            dialogue = {
                {LUNA4S, "Remember our strategy: I grab the shinies, you grab the consoles."},
                {BANKS, "Right, I teach them how to shout silence loud enough that no one hears us."},
                {BANKS, "And of course, you'll split the swag after the mission."},
            },
        })

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, XU},
            dialogue = {
                {LUNA4S, "-while the lattice itself glows blue."},
                {XU, "That's the Tyndall effect. We can mitigate it by minimizing sub-surface scattering..."},
            },
        })

end
