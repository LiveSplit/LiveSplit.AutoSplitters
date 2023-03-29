// Fantastic 4 2005 Autosplitter Version 1.1.0 31/1/2023
// Supports IGT/LRT/RTA
// Supports all difficulties
// Pointers and Script <by> ||LeonSReckon||

state("Game")
{
	float IGT: 0x14035C, 0x10;
	int inMenu: 0x0105F8, 0x8;
	int lvl: 0x69ADC4, 0x38;
	int input: 0x35028C, 0x458;
	int Cut: 0x128D98, 0x0;
	int Cha: 0x11D224, 0x248;
	int hbar: 0x22218C, 0x44C, 0x1A8, 0x788;
}

startup
{
		settings.Add("LRT", true, "LRT");
		settings.SetToolTip("LRT", "Tick this box if you're using load remover timer");
		settings.Add("IGT", false, "IGT");
		settings.SetToolTip("IGT", "Tick this box if you're using in game timer");
		
}

init
{
	vars.totalGameTime = 0;
}

start
{
	if(settings["LRT"] || settings["IGT"]){
		if(current.IGT > old.IGT){
			vars.totalGameTime = 0;
			return true;
		}
	}
}

split
{
	if(settings["LRT"]){
		if(current.lvl != old.lvl || current.Cha > old.Cha && current.input < old.input && current.Cut < old.Cut && current.lvl == 173){
			return true;
		}
	}
    
    if(settings["IGT"]){
	if (current.inMenu == 11003012 && old.inMenu == 0) {
        return true; 
		}
	}

}
	
isLoading
{
	if(settings["LRT"]){
		
		if((current.inMenu == 10986588 || current.IGT == old.IGT && current.inMenu != 0 && old.inMenu != 11007008 && current.inMenu != 11037784) && current.inMenu != 11003012 && current.inMenu !=10988728){
			return true;
		}
        else{
            return false;
        }
	}
	
	if(settings["IGT"]){
		return true;
	}
}

gameTime
{
	if(settings["IGT"]){
		if(current.IGT > old.IGT){
		return TimeSpan.FromSeconds(Math.Floor(vars.totalGameTime + current.IGT));
	}
	if(current.IGT == 0 && old.IGT > 0){
			vars.totalGameTime = System.Math.Floor(vars.totalGameTime + old.IGT);
			return TimeSpan.FromSeconds(System.Math.Floor(vars.totalGameTime + current.IGT));
		}
	}
}

reset
{
	if(settings["LRT"] || settings["IGT"]){
		if(current.inMenu == 11016456 || current.inMenu == 11009572){
		return true;
	}
	}
}
