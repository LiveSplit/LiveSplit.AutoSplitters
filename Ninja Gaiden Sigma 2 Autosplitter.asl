// Autosplitter by LonerHero and Mysterion_06_
state("NINJA GAIDEN SIGMA2"){
    byte start3: 0x1EB3BCD; // Stays 1 until you get in chapter 1 screen and press proceed. Allows you to change costume at start still
    byte chapter: 0x64BCCAE; // Current chapter value; e.g. current chapter is 10, pointer = 10 / Exception: Chapter 1-7 = 0-6
    byte cutscene: 0x1E67630; // 1 = If game plays any cutscene. Used for final cutscene against Archfiend
    byte BOTAKill: 0x2FDE960; // Total Dual sword kill count for HP fetch check
    short curBossHP: 0x67A6550; // Checking boss HP
    short ArchFiendmaxHP: 0x31B3E74; //This variable is focused on Archfiend HP Acolyte and Warrior HP is 11250 13500 for Mentor MN HP is 16875 // old.start1 == 1 && current.start1 == 0 
}

init{
	vars.completedSplitsInt = new List<int>();
}

update
{
	//Reset variables when the timer is reset.
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.completedSplitsInt.Clear();
	}
}

start{
    if(current.start3 == 0 && current.chapter == 0){
        return true;
    }
}

split{
    // Chapter Splits
    if(current.chapter > old.chapter){
        return true;
    }

    // Final Split
    if((old.ArchFiendmaxHP == 11250 || old.ArchFiendmaxHP == 13500 ||old.ArchFiendmaxHP == 16875) && current.curBossHP == 0 && current.chapter == 16 && current.cutscene == 1){
        return true;
    }

}			

/* reset{
    if(current.chapter < old.chapter){
        return true;
    }
} */