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

    -- By: Mobbstar;
    modApi:addBanter({
            agents = {LUNA4S, GOOSE},
            dialogue = {
                {GOOSE, "<HONK>"},
                {LUNA4S, "<hoot>"},
            },
        })

end
