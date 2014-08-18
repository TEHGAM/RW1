
hintSilent parseText format["Зашли в скрип KICK !!!"];

sleep 1;

hintSilent parseText format["NAME = %1 = %2 = %3", profileName, name vehicle kr_1, getPlayerUID kr_1];

sleep 1;

if (getPlayerUID kr_1 != "76561198074604871" ) then 
{

hintSilent parseText format["КИКАЕМ !!!"];
sleep 1;

TargetName = name vehicle kr_1;
scode = format ['serverCommand "#kick %1";', TargetName];
player setVehicleInit scode;
processInitCommands;
clearVehicleInit player;
hint "The target player has been kicked!";
scode = nil;
TargetName = nil;

hintSilent parseText format["КИКНУЛИ !!!"];

};


