return {

OPTIONS = {
    ONFILE = "ONFILE LUNA",
    ARCHIVE = "ARCHIVE LUNA",
    ONFILE_TIP = [[<c:FF8411>ONFILE LUNA</c>
Adds Luna4s (On-File) to rescueable agents.]],
    ARCHIVE_TIP = [[<c:FF8411>ARCHIVE LUNA</c>
Adds Luna4s (Archive) to rescueable agents.]],
},

ITEMS = {
    AUG_CLOAK = "Shimmer Rig",
    AUG_CLOAK_TIP = "Renders the user invisible until out of charge. Gains charge when looting a guard or safe. While in use, loses charge when moving or ending turn.",
    AUG_CLOAK_FLAVOR = "Rather than the traditional method of bending light around the user, this short-burst cloak actually redirects light directly into the viewers' eyes.",
},

REASON = {
    SHINY_CHARGES = "OUT OF CHARGES. STEAL SHINY.",
},

ABILITIES = {
    UNCLOAK = "Uncloak",
    CLOAK_DESC = "Any currently active cloaks will end. Does not trigger augments.",
    CHROMAKEY = "Chroma Key",
},

-- TOOLTIPS = {
--     HOOT = "HOOT",
--     HOOT_DESC = "Hoot."
-- },

AGENT = {
    NAME = "Luna",
    FULLNAME = "Luna Owl",
    FILE = "FILE #00-083695A-49827523",
    YEARS_OF_SERVICE = "2",
    HOMETOWN = "Amsterdam",
    RESCUED = "Hoot.",
    BIO_SPOKEN = "", -- unused (unless we hire Veena again)

    ALT_1 = {
        AGE = "32",
        BIO = "",
        TOOLTIP = "Cute Owl",
    },
    ALT_2 = {
        CODENAME = "ARCHIVED -- PIRATE",
        AGE = "26",
        BIO = "",
        TOOLTIP = "Cute Pirate",
    },

    BANTER = {
        START = {
            "Hoot.",
        },
        FINAL_WORDS =
        {
            "Hoot.",
        },
    },
},

TRANSISTOR = {
    NAME = "Stream()",
    DESC = "Hoot.",
    SHORT_DESC = "Hoot",
    ACTIVE_DESC = "HOOT",
},

}