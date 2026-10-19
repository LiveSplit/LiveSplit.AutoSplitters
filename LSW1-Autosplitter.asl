state("LegoStarwars")
{
    byte status : 0x39C58D;
    byte start : 0x39B0D0;
    byte title : 0x37B618;
    byte cutscene : 0x38D04C;
    string16 door : 0x39B0E0;
    string64 levelpath : 0x37220C, 0x0;
    byte currscene : 0x371444;
}

startup
{
    settings.Add("newgame", true, "Start on New Game");
    settings.Add("freeplay", false, "Start on Level Entry (Free Play)");
    settings.Add("maul", true, "End on Darth Maul Outro (Any%)");
    settings.Add("vader", false, "End on Darth Vader Outro (All Minikits)");
    settings.Add("anh", false, "End on A New Hope Outro (100% NSR)");
    settings.Add("dooku", false, "End on Count Dooku Outro (NoCut Any%)");
    settings.Add("room", false, "Split on every room in Any%");
    settings.Add("resetonmenu", true, "Reset Timer if Manually Exited to Main Menu");
    refreshRate = 60;
}

init
{
    vars.dinerLeeway = 0;
}

update
{
    if (current.levelpath == "levels\\Map\\Map_E")
    {
        vars.dinerLeeway = 60; // ~1 second of leeway at refreshRate 60, counts down every tick you're not in the diner
    }
    else if (vars.dinerLeeway > 0)
    {
        vars.dinerLeeway--;
    }
}

split
{
    if (current.status == 18 && old.status == 0) return true;
    if (current.status == 18 && old.status == 5) return true; // kamino freeplay fix
    if (settings["room"] && current.door == "door_to_hangar" && old.door != current.door) return true; // negotiations
    if (settings["room"] && current.door == "door_into_ruins1" && old.door != current.door) return true; // invasion
    if (settings["room"] && current.door == "door_into_ruins2" && old.door != current.door) return true;
    if (settings["room"] && old.door == "door_into_ruins2" && current.door != old.door) return true;
    if (settings["room"] && current.door == "RescueA_RescueB" && old.door != current.door) return true; // escape
    if (settings["room"] && current.door == "RescueB_RescueC" && old.door != current.door) return true;
    if (settings["room"] && current.door == "RescueC_RescueE" && old.door != current.door) return true;
    if (settings["room"] && current.door == "retakeA_retakeB" && old.door != current.door) return true; // theed
    if (settings["room"] && current.door == "retakeB_retakeD" && old.door != current.door) return true;
    if (settings["room"] && current.door == "retakeD_retakeE" && old.door != current.door) return true;
    if (settings["room"] && current.door == "retakeE_retakeF" && old.door != current.door) return true;
    if (settings["room"] && current.door == "Palace_Hangar" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door1in" && old.door != current.door) return true; // kamino
    if (settings["room"] && current.door == "door10out" && old.door != current.door) return true;
    if (settings["room"] && old.door == "door10out" && current.door != old.door) return true;
    if (settings["room"] && current.door == "door2corr" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door_bossout" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door_4" && old.door != current.door) return true; // factory
    if (settings["room"] && current.door == "door_3in" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door_5in" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door_6in" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door_8out" && old.door != current.door) return true;
    if (settings["room"] && current.door == "GunshipA_B" && old.door != current.door) return true; // gunship
    if (settings["room"] && current.door == "door_main_in" && old.door != current.door) return true; // dooku
    if (settings["room"] && current.door == "door_grev" && old.door != current.door) return true; // chancellor
    if (settings["room"] && old.door == "door_vent2" && current.door != old.door) return true;
    if (settings["room"] && current.door == "door_lobby_out2" && old.door != current.door) return true;
    if (settings["room"] && old.door == "door_shaft_out3" && current.door != old.door) return true;
    if (settings["room"] && current.door == "door_to_beach" && old.door != current.door) return true; // kashyyyk
    if (settings["room"] && current.door == "door_to_swamp" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door_to_forest" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door_to_inside" && old.door != current.door) return true; // ruin
    if (settings["room"] && current.door == "door_to_archive" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door_to_control" && old.door != current.door) return true;
    if (settings["room"] && current.vader == "oor_ledge1" && old.vader != current.vader) return true; // vader
    if (settings["room"] && current.door == "door_fight" && old.door != current.door) return true;
    if (settings["room"] && current.door == "door_2" && old.door != current.door) return true; // maul
    if (settings["room"] && current.door == "door_3" && old.door != current.door) return true;
    if (settings["room"] && old.door == "door_3" && current.door != old.door) return true;
    if (settings["room"] && current.door == "door_8" && old.door != current.door) return true;
    if (settings["maul"] && current.door == "door_8" && current.cutscene == 1) return true;
    if (settings["vader"] && current.door == "door_fight" && current.cutscene == 1) return true;
    if (settings["anh"] && current.door == "door_from_room2" && current.cutscene == 1) return true;
    if (settings["dooku"] && current.levelpath == "levels\\episode_ii\\chapter_07\\Dooku_Outro") return true; // dooku outro
}

start
{
    if (settings["newgame"] && current.start > old.start && current.title == 1 && current.currscene == 124) return true; // ty coolestto
    if (settings["freeplay"] && current.door == "") return true;
}

reset
{
    if (settings["resetonmenu"] && current.levelpath == "levels\\titles" && old.levelpath != "levels\\titles" && vars.dinerLeeway > 0)
    {
        vars.dinerLeeway = 0;
        return true;
    }
}
