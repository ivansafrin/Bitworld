
AI_MELEE = 0
AI_ARCHER = 1
AI_MAGE = 2

creatureLibrary = {
    orcraider = {name="Orc Raider", imageIndex=162, HP=2, speed=0.5, aitype=AI_MELEE, hasShield=false},
    orcenforcer = {name="Orc Enforcer", imageIndex=162, HP=4, speed=0.4, aitype=AI_MELEE, hasShield=true},
    orcarchereasy = {name="Orc Archer Apprentice", imageIndex=163, HP=1, speed=0.3, aitype=AI_ARCHER, hasShield=false},
    orcarchermed = {name="Orc Archer", imageIndex=163, HP=2, speed=0.4, aitype=AI_ARCHER, hasShield=false},
    greenslime = {name="Green Slime", blood="YellowBlood", imageIndex=243, HP=1, speed=0.3, aitype=AI_MELEE, hasShield=false},
    blueslime = {name="Blue Slime", blood="YellowBlood", imageIndex=244, HP=2, speed=0.4, aitype=AI_MELEE, hasShield=false},
    fireslime = {name="Fire Slime", blood="BlackBlood", imageIndex=246, HP=3, speed=0.3, aitype=AI_MELEE, hasShield=false},
    firehorror = {name="Fire Horror", blood="BlackBlood", imageIndex=254, HP=2, speed=0.4, aitype=AI_MELEE, hasShield=false},
    darkeye = {name="Fire Eye", blood="BlackBlood", imageIndex=250, HP=4, speed=0.4, aitype=AI_MAGE, spellID=0, hasShield=false},
    skelsoldier = {name="Skeleton Soldier", blood="SkelBlood", imageIndex=192, HP=2, speed=0.3, aitype=AI_MELEE, hasShield=false},
    skelpikeman = {name="Skeleton Pikeman", blood="SkelBlood", imageIndex=193, HP=2, speed=0.5, aitype=AI_MELEE, hasShield=false},
    skelknight = {name="Skeleton Knight", blood="SkelBlood", imageIndex=192, HP=3, speed=0.5, aitype=AI_MELEE, hasShield=true},
    darkknight = {name="Dark Knight", blood="BlackBlood", imageIndex=43, HP=10, speed=0.3, aitype=AI_MELEE, hasShield=true},
    darkmage = {name="Dark Mage", blood="BlackBlood", imageIndex=87, HP=2, speed=0.4, aitype=AI_MAGE, hasShield=false, spellID=0},
    icemage = {name="Ice Mage", imageIndex=113, HP=1, speed=0.4, aitype=AI_MAGE, hasShield=false, spellID=1},
    dwarf = {name="Dwarf", imageIndex=90, HP=1, speed=0.4, aitype=AI_MELEE, hasShield=false},
    dwarfguard = {name="Dwarf Guard", imageIndex=100, HP=10, speed=0.4, aitype=AI_MELEE, hasShield=true},
    dwarfcaptain = {name="Dwarf Captain", imageIndex=102, HP=10, speed=0.4, aitype=AI_MELEE, hasShield=true},
    dwarfknight = {name="Dwarf Knight", imageIndex=99, HP=6, speed=0.4, aitype=AI_MELEE, hasShield=true},
    dwarfmage = {name="Dwarf Mage", imageIndex=91, HP=4, speed=0.4, aitype=AI_MAGE, spellID=1, hasShield=false},
    dwarfking = {name="Dwarf King", imageIndex=104, HP=1, speed=0.2, aitype=AI_MELEE, hasShield=false},
    elfrogue = {name="Elf Rogue", imageIndex=18, HP=2, speed=0.6, aitype=AI_ARCHER, hasShield=false},
    dragonboss = {name="The Red Beast", blood="BlackBlood", imageIndex=666, HP=40, speed=0.4, aitype=AI_MAGE, spellID=0, hasShield=false},
    dummypost = {name="Dummy Post", blood="WoodBlood", imageIndex=273, HP=100000, speed=0, aitype=AI_MELEE, dummy=true, hasShield=false},
    halfimp = {name="Half Imp", blood="BlackBlood", imageIndex=154, HP=2, speed=0.6, aitype=AI_MELEE, hasShield=false},
    halfimpknight = {name="Half Imp Knight", blood="BlackBlood", imageIndex=154, HP=5, speed=0.4, aitype=AI_MELEE, hasShield=true},
    halfimparcher = {name="Half Imp Archer", blood="BlackBlood", imageIndex=155, HP=3, speed=0.3, aitype=AI_ARCHER, hasShield=false},
    imp = {name="Imp", blood="BlackBlood", imageIndex=171, HP=2, speed=0.8, aitype=AI_MELEE, hasShield=false},
    darkimp = {name="Dark Imp", blood="BlackBlood", imageIndex=173, HP=3, speed=0.8, aitype=AI_MAGE,spellID=0, hasShield=false},
    fireskull = {name="Fire Skull", blood="BlackBlood", imageIndex=202, HP=3, speed=0.7, aitype=AI_MELEE, hasShield=false},
}


npcLibrary = {
    gloomydwarf = {name="GLOOMY DWARF", x=23,y=20,base="dwarf", speechlines={"WELCOME TO OUR FORTRESS...","OR RATHER WHAT'S LEFT OF IT","..."}},
    theking = {name="FORTRESS SUPERVISOR", x=23,y=16,base="dwarfking", speechlines={"HEAR, HEAR!", "HEAR THE SHADOWY STORY OF OUR FORTRESS!","WE CAME HERE MANY YEARS AGO...","SEVEN DWARVES ON A MISSION FROM THE KING...","TO BUILD A COLONY DEEP IN THE MOUNTAINS...","A GLORIOUS FORTRESS WHERE ONLY ROCK HAD BEEN...","TOILING DAY AND NIGHT WE CARVED THE STONE...","AND AFTER MANY YEARS OF WORK WE BUILT OUR HOME...","AN UNDERGROUND DWELLING...","THE LIKES OF WHICH NOONE HAS SEEN...","CARAVANS CAME HERE FROM ALL ENDS OF THE WORLD...","THE GEMS WE DUG OUT FROM OUR MINES...","WERE FAMOUS THE WORLD OVER...","THE DEEPER WE DUG...", "THE MORE WONDEROUS STONES WE FOUND...","UNTIL THAT FATEFUL DAY...","WHEN OUR MINERS HIT UPON A MYSTERIOUS METAL...","WE CALLED IT...","ADAMANTINE!","......","...AMID OUR CELEBRATIONS...","WE COULD BARELY REACT TO WHAT HAPPENED NEXT...","ALL HELL BROKE LOOSE DOWN IN THE FORTRESS...","MONSTERS, ONE MORE HIDEOUS THAN THE NEXT...","SWARMED OUR BELOVED HOME...","FIRE FILLED THE LOWER LEVELS...","AND A GREAT RED BEAST...","SWEPT THROUGH OUR SACRED CAVERNS...", "DESTROYING ALL IN SIGHT...", "MOST OF OUR BRETHREN DIED THAT DAY...","BUT A FEW OF US ESCAPED...", "AND NOW WE GUARD THE ENTRANCE TO THIS...","...THIS TOMB","BRAVE HERO...","PERHAPS YOU CAN RID OUR HOME OF THIS PLAGUE!","PERHAPS YOU CAN SLAY THE GREAT RED BEAST!"}},
    captaintutorial = {name="CAPTAIN TUTORIAL", x=23,y=35,base="dwarfcaptain", speechlines={"WHATS THIS?","MORE BLOOD FOR THE BLOOD GOD?", "EXCELLENT!", "I RUN THESE HERE TRAINING GROUNDS.", "SEE THOSE THREE OVER THERE?", "TALK TO ONE THAT LOOKS LIKE YOU...", "THEN TALK TO THE GUY ACROSS FROM THEM...", "THEN YOU'LL BE GOLDEN.","HE HE"}},
    tutorialknight = {name="KNIGHT INSTRUCTOR", x=24,y=37,base="dwarfknight", onlytalk="knight", nospeechlines={"I TRAIN KNIGHTS...","NOT LITTLE GIRLS"}, speechlines={"SO YOU WANT TO BE A KNIGHT, HUH?", "...", "HAVE YOU EVER WRESTLED A BEAR?", "I HAVE", "MANY!", "ANYWAY, THIS IS PRETTY STRAIGHTFORWARD STUFF", "YOU GOT A SWORD AND YOU GOT A SHIELD", "HOLD DOWN THE 'Z' KEY TO HOLD UP THE SHIELD", "PRESS THE 'X' KEY TO ATTACK WITH THE SWORD", "KEEP IN MIND YOU MOVE SLOWER BEHIND THE SHIELD", "AND YOU CANNOT ATTACK WHEN HOLDING IT UP","THAT'S ALL THERE IS TO IT!", "TAKE CARE OF YOURSELF, SON", "ITS HELL DOWN THERE"}},
    tutorialmage = {name="MAGE INSTRUCTOR", x=24,y=39,base="dwarfmage", onlytalk="wizard", nospeechlines={"WHAT'S THE OPPOSITE OF 'MAGICAL'?","WHATEVER IT IS, YOU ARE IT","GO AWAY"}, speechlines={"DO WHAT THOU WILT...","SHALL BE THE WHOLE OF THE LAW", "JUST KIDDING!", "THAT WILL GET YOU KILLED", "ANYWAY!", "HOW IT WORKS IS LIKE THIS", "YOU CAST SPELLS BY CHARGING THEM", "HOLD DOWN 'Z' TO CHARGE YOUR ICEBALLS", "HOLD DOWN 'X' TO CHARGE YOUR FIREBALLS", "THEY WILL FIRE AUTOMATICALLY WHEN CHARGED", "USE THE ICEBALLS TO KEEP ENEMIES AT BAY", "AND THEN BURN THEM WITH FIREBALLS!","IT'S A LOT OF FUN!"}},
    tutorialarcher = {name="ARCHER INSTRUCTOR", x=22,y=40,base="elfrogue", onlytalk="archer", nospeechlines={"DO YOU HAVE A BOW AND ARROW?","NO?","OH BOY"}, speechlines={"FINALLY!", "SOMEONE I CAN TALK TO", "I TRIED TEACHING ONE OF THE DWARVES HOW TO SHOOT", "UNFORTUNATELY, HE ENDED UP...", "EH, IT'S NOT THAT IMPORTANT", "WHAT'S IMPORTANT IS TEACHING YOU!", "IT'S QUITE SIMPLE, REALLY", "HOLD DOWN 'X' TO BUILD UP POWER AND RELEASE", "THE LONGER YOU HOLD IT DOWN, THE FARTHER IT GOES", "YOU CAN PRACTICE IN THE RANGE OVER THERE", "OH, ONE OTHER THING","YOU CAN HOLD DOWN 'Z' TO BRIEFLY CLOAK YOURSELF", "ENEMIES WILL LOSE SIGHT OF YOU...", "BUT IT ONLY LASTS A FEW MOMENTS...","AND YOU WONT BE ABLE TO USE IT FOR A MOMENT...", "SO BE QUICK!", "THAT'S IT!"}},
    tutorialmove = {name="GENERAL INSTRUCTOR", x=17,y=37,base="dwarfguard", speechlines={"OK, I GOTTA TELL YOU ABOUT SOMETHING VITAL", "ALL COMBAT AROUND HERE TAKES PLACE SIDEWAYS", "SO YOU CAN ONLY ATTACK LEFT AND RIGHT", "GOOD NEWS IS ALL THE ENEMIES ARE THE SAME WAY!", "ANYWAY", "IT DOESN'T MEAN YOU CAN'T ATTACK UP AND DOWN", "BUT YOU HAVE TO SWITCH TO THAT AXIS FIRST", "USE SPACEBAR TO TOGGLE BETWEEN THE TWO AXISES","AXISESES","WHATEVER","THAT WILL LET YOU FIGHT IN ALL DIRECTIONS","OH!","PRESS 'C' KEY TO JUMP", "THAT'S ALL!! GO AT EM!"}},
    gatekeeper = {name="GATEKEEPER", x=30,y=31,base="dwarfguard", speechlines={"THE OLD FORTRESS IS THROUGH HERE...","TALK TO CAPTAIN TUTORIAL IF YOU'VE NEVER BEEN...","SERIOUSLY!"}},
    gatekeeper2 = {name="SENTRY", x=34,y=31,base="dwarfguard", speechlines={"YOU DO KNOW WHAT YOU'RE DOING RIGHT?", "THEY TOLD YOU ABOUT SPACEBAR AND ALL THAT?","OK, JUST CHECKING!","BEST OF LUCK!!!"}}

}

villageNPCs = {"gloomydwarf", "theking", "gatekeeper", "gatekeeper2", "captaintutorial", "tutorialknight", "tutorialmage", "tutorialarcher", "tutorialmove"}
